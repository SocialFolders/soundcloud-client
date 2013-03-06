Soundcloud API Client
=====================

This is a configurable client for SoundCloud, based on Faraday.

The base class is Soundcloud::API, which reflects the documented API as 
instance methods.

The API might be configured (at the class level) with client credentials
to enable OAuth2 token retrieval, but the usage is just at the instance level
when a token is available.

To be able to use persistent connections and reduce the overall time to
connect the server, the connection object (Faraday::Connection) is stored
in the class when possible, and each instance will use the same connection.


API configuration
-----------------

To configure the API credentials and other parameters, the API.configure method
must be used.

Example:

    Soundcloud::API.configure(mime: "application/json",
                              host: "https://api.soundcloud.com",
                              adapter: :net_http,
                              client_id: "0123456789abcdef0123456789abcdef",
                              client_secret: "0123456789abcdef0123456789abcdef",
                              redirect_uri: "http://example.com/redirect_path"
                              )

All options are optional, where :mime and :host defaults are those specified
above, and the default adapter (for Faraday) is `Faraday.default_adapter`, so
it can be configured globally if needed.

If the client\_id, client\_secret or redirect\_uri are missing, the API won't
be able to provide the url for authorization, nor to exchange temporary user
credentials with permanent ones.


API access
----------

All documented API endpoints are mapped as methods on API instances. Thus, 

    @api.tracks(filter: "downloadable", offset: 50)

will retrieve the second page of downloadable tracks, while

    @api.user_favorites(user)

will retrieve the first page of favorites for the specified user. To create
a new object, une must use for instance

    @api.create_track(title: "Track title", asset_data: some_uploadio_instance)


Positional arguments (which are required to build the request path) can be
passed either as plain IDs (string or integer, it doesn't matter) or as hashes,
in which case an "id" or :id key is used.

In the same way, the returned objects are hashes, representing the domain
objects. Those same objects can be used again as positional arguments for 
parametrized queries, and also as content arguments for methods which send
data to SoundCloud.


User authorization
------------------

To access user's data, one must initalize the API instance with a OAuth2 token:

    @api = Soundcloud::API.new("1-12345-12345678-0123456789abcdef")

This instance will be able to retrieve user's priavte data, and also to send
modifying commands, like favoriting a track, following a user, uploading a
track etc.


Data retrieval
--------------

All of the following endpoints are represented as methods, with the corresponding
subresources:

- `@api.users(options)` => "/users"
- `@api.user(user_or_id)` => "/users/_id_"
- `@api.user_tracks(user_or_id, options)` => "/users/_id_/tracks"
- `@api.user_playlists(user_or_id, options)` => "/users/_id_/playlists"
- `@api.user_web_profiles(user_or_id, options)` => "/users/_id_/web-profiles"
- `@api.user_followings(user_or_id, options)` => "/users/_id_/followings"
- `@api.user_followers(user_or_id, options)` => "/users/_id_/followers"
- `@api.user_comments(user_or_id, options)` => "/users/_id_/comments"
- `@api.user_favorites(user_or_id, options)` => "/users/_id_/favorites"
- `@api.user_connections` => "/users/me/connections"
- `@api.user_activities` => "/users/me/activities"
- `@api.tracks(options)` => "/tracks"
- `@api.track(track_or_id)` => "/tracks/_id_"
- `@api.track_comments(track_or_id, options)` => "/tracks/_id_/comments"
- ...

and so on. Running the spec will provide a list of all the retrieval methods.

The data is returned as hashes or lists of hashes, whose keys follow strictly
what provided by the SoundCloud servers. The same hashes can be used as 
positional arguments (so a hash retrieved in the response of `@api.users()`
can be used as argument to `@api.user_favorites(user_or_id)`...).

If a hash is not available it can either be constructed on the fly (only its
`"id"` or `:id` keys are used) or just the ID may pe provided.

Some methods have special names, as for tracks and playlists, where 
`@api.track_shared_to_users(track)` maps to "/tracks/_id_/shared-to/users", as
the last slash does not separate an actual subresource.

There are a couple of boolean query methods:

- `@api.favorite?(track, user="me")` will return truthy if the specified user 
  (defaulting to the current user) has the track among its favorites.
- `@api.follow?(user, who="me")` will return truthy if the specified user
  (defaulting to the current user) is following the given one.


Modifying data
--------------

For each of the "/playlists", "/tracks" and "/groups" resources, three
additional methods are provided:

- `@api.create_track(data)` => `POST /tracks` with the track in the request body
- `@api.update_track(data)` => `PUT /tracks/id` with the track in the request body and the track ID in the URL
- `@api.delete_track(data)` => `DELETE /tracks/id` with the track ID in the URL

The `data` parameter must be a hash of attributes, with the same form as the one
returned from retrieving objects as above. In the case of `POST /tracks`, 
the `"asset_data"` or `:asset_data` key must be an instance of UploadIO (from
Faraday or from multipart-post gem) or a simpler File instance if possible.

Beware that in the actual requests, the body before serialization will be similar to
`{"track" => data}`. The serialization is done by `Faraday::Utils.build_nested_query`
so the resulting string is exactly what expected by Soundcloud servers. Array
elements are serialized as separate keys (or prefixes) with the string "[]" appended
to the parameter name, and hashes are serialized as separate keys, with the bracketed
key appended to te parameter name. So

    @api.create_playlist(title: "My Title", tracks: [{id: 123}, {id: 124}])

will be converted (before encoding) into

    playlist[title]=My Title&playlist[tracks][][id]=123&playlist[tracks][][id]=124



As for retrieval, special methods are provided for flagging objects (with respect to the current user):

- `@api.favorite!(track)`
- `@api.unfavorite!(track)`
- `@api.follow!(user)`
- `@api.unfollow!(user)`


Errors
------

In case of HTTP errors in the range 400-599, a corresponding error is raised,
which inherits from `Soundcloud::Error::Error` and contains the original
response data in its `response` attribute.

Specific errors can be rescued, for instance Soundcloud::Error::NotFound will
rescue from 404 error codes (which is probably desirable in some cases).


More configuration
------------------

The API instance can be configured with more options if needed. Currently the
supported options are

- `:verbose` if truthy, a logging middleware is added to the stack, so details
about the request and response headers, and the full response body are shown in
the log file.

- `:stubs` if truthy, it must act like a Faraday::Adapter::Test::Stubs instance
(it can duck-type it if necessary), and in that case the conection will use a
test adapter, instead of doing actual HTTP requests. All the needed requests
must be declared in the stubs object, as in

        @stubs = Faraday::Adapter::Test::Stubs.new
        @api = Soundcloud::API.new("no token needed in this case...", stubs: @stubs)
        @stubs.get("/tracks") do 
          [
           200,                                                 # status code
           {"Content-Type" => "application/json"},              # response headers
           '[{"id":123,"kind":"track","title":"Track Title"}]'  # response body
          ]
        end
        @api.tracks.should == [ {"id" => 123, "kind" => "track", "title" => "Track Title"} ]

