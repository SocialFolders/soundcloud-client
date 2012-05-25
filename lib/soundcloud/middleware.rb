require 'faraday'
require 'soundcloud/error'

module Soundcloud
  module Middleware

    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        case env[:status]
        when 400...600
          raise Soundcloud::Error[env[:status]], response_values(env)
        end
      end

      def response_values(env)
        {:status => env[:status], :headers => env[:response_headers], :body => env[:body]}
      end

    end


  end
end
