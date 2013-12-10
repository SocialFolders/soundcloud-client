require 'faraday'
require 'faraday_middleware'

require 'soundcloud/error'
require 'soundcloud/middleware'


module Soundcloud

  class API

    DEFAULT_ACCEPT = "application/json".freeze
    DEFAULT_HOST = 'https://api.soundcloud.com'
    AUTHORIZE_URL = 'https://soundcloud.com/connect'
    TOKEN_PATH = '/oauth2/token'

    class << self
      attr_reader :client_id, :client_secret, :redirect_uri
      attr_reader :mime, :adapter, :host

      def configure(options={})
        @client_id = options[:client_id]
        @client_secret = options[:client_secret]
        @redirect_uri = options[:redirect_uri]
        @mime = options[:mime] if options.key? :mime
        @host = options[:host] if options.key? :host
        @adapter = options[:adapter] if options[:adapter]
      end

      def user_agent
        "Soundcloud client v#{Soundcloud::VERSION}"
      end

      # Establish a class-wide connection, possibly to be able to use
      # persistent connections among requests and event-based things.
      def connection(opts={})
        @@connections ||= {}
        @@connections[opts] ||= Faraday.new(self.host, headers: {accept: self.mime, user_agent: self.user_agent}) do |builder|
          builder.request :multipart
          builder.request :url_encoded
          builder.use Soundcloud::Middleware::RaiseError
          builder.response :json, content_type: /\bjson$/
          builder.response :logger if opts[:verbose]
          builder.adapter self.adapter
        end
      end

      def authorize_url
        raise Soundcloud::Error::Unauthorized, "Missing configuration" unless client_id and client_secret and redirect_uri
        "#{AUTHORIZE_URL}?response_type=code&client_id=#{client_id}&redirect_uri=#{URI.escape redirect_uri}&scope=non-expiring"
      end

      def exchange_temporary_credentials(code, stubs=nil)
        raise Soundcloud::Error::Unauthorized, "Missing configuration" unless client_id and client_secret and redirect_uri
        begin
          parameters = {
            client_id: client_id, client_secret: client_secret, redirect_uri: redirect_uri,
            grant_type: 'authorization_code', code: code
          }
          Faraday.new do |builder|
            builder.request :url_encoded
            builder.response :json, content_type: /\bjson$/
            builder.adapter(*Array(stubs ? [:test, stubs] : self.adapter))
          end.post("#{host}#{TOKEN_PATH}") do |request|
            request.body parameters
          end
        rescue
          raise Soundcloud::Error::Unauthorized, "<#{$!.class}: #{$!}>"
        end
      end

    end

    self.configure(mime: DEFAULT_ACCEPT,
                   host: DEFAULT_HOST,
                   adapter: Faraday.default_adapter)


    attr_accessor :stubs, :verbose
    attr_accessor :token, :host

    # Options
    # :verbose  whether to print request/response. Request bodies are printed too
    # :mime   Content of the Accept header, indicates the format of the response. Default is json
    # :stubs    Instance of Faraday::Adapter::Test::Stubs, which will be used instead of the default adapter.
    def initialize(token, opts={})
      self.token = token
      self.verbose = !!opts[:verbose]
      self.stubs = opts[:stubs]
    end


    def connection(options={})
      options[:verbose] = self.verbose unless options.key?(:verbose) or !self.verbose
      stubs = options.delete(:stubs) || self.stubs
      conn = self.class.connection(options)
      if stubs
        conn = conn.dup
        conn.builder.handlers.delete_at(-1)
        conn.builder.adapter :test, self.stubs
      end
      conn
    end


    # RESTful API definitions:

    SUBRESOURCE_MAP = {
      user: [:tracks, :playlists, :groups, :web_profiles, :followings, :followers, :comments, :favorites, :connections, :activities],
      track: [:comments, :favoriters, [:shared_to_users, "shared-to/users"], [:shared_to_emails, "shared-to/emails"], :secret_token],
      playlist: [[:shared_to_users, "shared-to/users"], [:shared_to_emails, "shared-to/emails"], :secret_token],
      group: [:moderators, :members, :contributors, :users, :tracks, :pending_tracks, :contributions],
      app: [:tracks]
    }

    [:user, :track, :playlist, :group, :app, :comment].each do |resource|
      define_method(resource) do |ref|
        get("/#{resource}s/#{id_of ref}").body
      end
      define_method("#{resource}s") do |opts={}|
        get("/#{resource}s", opts).body
      end
      SUBRESOURCE_MAP.fetch(resource, []).each do |subresource|
        subresource, path = subresource if subresource.is_a? Array
        path ||= subresource.to_s.gsub("_", "-")
        define_method("#{resource}_#{subresource}") do |ref, opts={}|
          get("/#{resource}s/#{id_of ref}/#{path}", opts).body
        end
      end
    end

    # CRUD

    [:playlist, :track, :group].each do |resource|
      define_method("create_#{resource}") do |item|
        post("/#{resource}s", {resource => item}).body
      end
      define_method("update_#{resource}") do |item|
        put("/#{resource}s/#{id_of item}", {resource => item}).body
      end
      define_method("delete_#{resource}") do |item|
        delete("/#{resource}s/#{id_of item}").body
      end
    end


    def favorite!(track)
      put "/users/me/favorites/#{id_of track}"
    end
    alias :favorite :favorite!

    def unfavorite!(track)
      delete "/users/me/favorites/#{id_of track}"
    end
    alias :unfavorite :unfavorite!

    def favorite?(track, who="me")
      get "/users/#{id_of who}/favorites/#{id_of track}"
    rescue Soundcloud::Error::NotFound
      false
    end

    def follow!(user)
      put "/users/me/followings/#{id_of user}"
    end

    def unfollow!(user)
      delete "/users/me/followings/#{id_of user}"
    rescue Soundcloud::Error::NotFound
      false
    end

    def follow?(user, who="me")
      get "/users/#{id_of who}/followings/#{id_of user}"
    rescue Soundcloud::Error::NotFound
      false
    end

    def id_of(item)
      id = item["id"] || item[:id] if item.is_a?(Hash)
      id || item
    end

    def auth_header
      { authorization: "OAuth #{self.token}" } if self.token and !self.token.empty?
    end

    Faraday::Connection::METHODS.each do |method|
      define_method(method) do |url=nil, params=nil, headers=nil|
        if auth_header
          if headers
            headers.update(auth_header)
          else
            headers = {}.merge(auth_header)
          end
        end
        connection.send method, url, params, headers
      end
    end

  end
end
