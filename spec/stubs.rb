require 'faraday'

SAMPLES = {

  user: <<-JS.gsub(/\s+/, " "),
  {
    "id": 3207,
    "permalink": "jwagener",
    "username": "Johannes Wagener",
    "uri": "http://api.soundcloud.com/users/3207",
    "permalink_url": "http://soundcloud.com/jwagener",
    "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848",
    "country": "Germany",
    "full_name": "Johannes Wagener",
    "city": "Berlin",
    "description": "<b>Hacker at SoundCloud</b>\r\n\r\nSome of my recent Hacks:\r\n\r\nsoundiverse.com \r\nbrowse recordings with the FiRe app by artwork\r\n\r\ntopbillin.com \r\nfind people to follow on SoundCloud\r\n\r\nchatter.fm \r\nget your account hooked up with a voicebox\r\n\r\nrecbutton.com \r\nrecord straight to your soundcloud account",
    "discogs_name": null,
    "myspace_name": null,
    "website": "http://johannes.wagener.cc",
    "website_title": "johannes.wagener.cc",
    "online": true,
    "track_count": 12,
    "playlist_count": 1,
    "followers_count": 417,
    "followings_count": 174,
    "public_favorites_count": 26
  }
  JS

  users: <<-JS.gsub(/\s+/, " "),
  [
    {
      "id": 1007028,
      "permalink": "lansinghiphop",
      "username": "LansingHipHop",
      "uri": "http://api.soundcloud.com/users/1007028",
      "permalink_url": "http://soundcloud.com/lansinghiphop",
      "avatar_url": "http://i1.sndcdn.com/avatars-000001229324-2l55vi-large.jpg?142a848",
      "country": "United States",
      "full_name": "Lansing HipHop",
      "city": "Lansing",
      "description": null,
      "discogs_name": null,
      "myspace_name": null,
      "website": null,
      "website_title": null,
      "online": false,
      "track_count": 1,
      "playlist_count": 0,
      "followers_count": 97,
      "followings_count": 0,
      "public_favorites_count": 0
    },
    {
      "id": 1858228,
      "permalink": "chicoseah",
      "username": "ChicoSeah",
      "uri": "http://api.soundcloud.com/users/1858228",
      "permalink_url": "http://soundcloud.com/chicoseah",
      "avatar_url": "http://i1.sndcdn.com/avatars-000001837875-prjwx9-large.jpg?142a848",
      "country": null,
      "full_name": "HipHop",
      "city": "ZNC",
      "description": null,
      "discogs_name": null,
      "myspace_name": null,
      "website": null,
      "website_title": null,
      "online": false,
      "track_count": 1,
      "playlist_count": 0,
      "followers_count": 41,
      "followings_count": 3,
      "public_favorites_count": 0
    },
    {
      "id": 2168214,
      "permalink": "hip-hop-2",
      "username": "hip hop",
      "uri": "http://api.soundcloud.com/users/2168214",
      "permalink_url": "http://soundcloud.com/hip-hop-2",
      "avatar_url": "http://a1.sndcdn.com/images/default_avatar_large.png?142a848",
      "country": "United States",
      "full_name": "hiphop",
      "city": "new york",
      "description": null,
      "discogs_name": null,
      "myspace_name": null,
      "website": null,
      "website_title": null,
      "online": false,
      "track_count": 3,
      "playlist_count": 0,
      "followers_count": 99,
      "followings_count": 1,
      "public_favorites_count": 0
    },
    {
      "id": 1562800,
      "permalink": "chedee-1",
      "username": "Chedee",
      "uri": "http://api.soundcloud.com/users/1562800",
      "permalink_url": "http://soundcloud.com/chedee-1",
      "avatar_url": "http://i1.sndcdn.com/avatars-000003117449-uj69ym-large.jpg?142a848",
      "country": "Switzerland",
      "full_name": "HipHop",
      "city": "Zurich",
      "description": "Street Guerilla",
      "discogs_name": "Chedee",
      "myspace_name": null,
      "website": null,
      "website_title": null,
      "online": false,
      "track_count": 7,
      "playlist_count": 2,
      "followers_count": 105,
      "followings_count": 51,
      "public_favorites_count": 1
    },
    {
      "id": 3498284,
      "permalink": "hiphop-honky",
      "username": "hiphop-honky",
      "uri": "http://api.soundcloud.com/users/3498284",
      "permalink_url": "http://soundcloud.com/hiphop-honky",
      "avatar_url": "http://i1.sndcdn.com/avatars-000002860787-fdb9ga-large.jpg?142a848",
      "country": "United States",
      "full_name": "HipHop Honky",
      "city": "Portland",
      "description": "I BELIEVE.....\r\n\r\n",
      "discogs_name": null,
      "myspace_name": null,
      "website": null,
      "website_title": null,
      "online": false,
      "track_count": 4,
      "playlist_count": 0,
      "followers_count": 9,
      "followings_count": 0,
      "public_favorites_count": 0
    }
  ]
  JS

  track: <<-JS.gsub(/\s+/, " "),
  {
    "id": 13158665,
    "created_at": "2011/04/06 15:37:43 +0000",
    "user_id": 3699101,
    "duration": 18109,
    "commentable": true,
    "state": "finished",
    "sharing": "public",
    "tag_list": "soundcloud:source=iphone-record",
    "permalink": "munching-at-tiannas-house",
    "description": null,
    "streamable": true,
    "downloadable": true,
    "genre": null,
    "release": null,
    "purchase_url": null,
    "label_id": null,
    "label_name": null,
    "isrc": null,
    "video_url": null,
    "track_type": "recording",
    "key_signature": null,
    "bpm": null,
    "title": "Munching at Tiannas house",
    "release_year": null,
    "release_month": null,
    "release_day": null,
    "original_format": "m4a",
    "original_content_size": 10211857,
    "license": "all-rights-reserved",
    "uri": "http://api.soundcloud.com/tracks/13158665",
    "permalink_url": "http://soundcloud.com/user2835985/munching-at-tiannas-house",
    "artwork_url": null,
    "waveform_url": "http://w1.sndcdn.com/fxguEjG4ax6B_m.png",
    "user": {
      "id": 3699101,
      "permalink": "user2835985",
      "username": "user2835985",
      "uri": "http://api.soundcloud.com/users/3699101",
      "permalink_url": "http://soundcloud.com/user2835985",
      "avatar_url": "http://a1.sndcdn.com/images/default_avatar_large.png?142a848"
    },
    "stream_url": "http://api.soundcloud.com/tracks/13158665/stream",
    "download_url": "http://api.soundcloud.com/tracks/13158665/download",
    "playback_count": 0,
    "download_count": 0,
    "favoritings_count": 0,
    "comment_count": 0,
    "created_with": {
      "id": 124,
      "name": "SoundCloud iPhone",
      "uri": "http://api.soundcloud.com/apps/124",
      "permalink_url": "http://soundcloud.com/apps/iphone"
    },
    "attachments_uri": "http://api.soundcloud.com/tracks/13158665/attachments"
  }
  JS

  playlist: <<-JS.gsub(/\s+/, " "),
  {
    "id": 405726,
    "created_at": "2010/11/02 09:24:50 +0000",
    "user_id": 3207,
    "duration": 154516,
    "sharing": "public",
    "tag_list": "",
    "permalink": "field-recordings",
    "description": "a couple of field recordings to test http://soundiverse.com.\r\n\r\nrecorded with the fire recorder: http://soundcloud.com/apps/fire",
    "streamable": true,
    "downloadable": true,
    "genre": "",
    "release": "",
    "purchase_url": null,
    "label_id": null,
    "label_name": "",
    "type": "other",
    "playlist_type": "other",
    "ean": "",
    "title": "Field Recordings",
    "release_year": null,
    "release_month": null,
    "release_day": null,
    "license": "cc-by",
    "uri": "http://api.soundcloud.com/playlists/405726",
    "permalink_url": "http://soundcloud.com/jwagener/sets/field-recordings",
    "artwork_url": null,
    "user": {
      "id": 3207,
      "permalink": "jwagener",
      "username": "Johannes Wagener",
      "uri": "http://api.soundcloud.com/users/3207",
      "permalink_url": "http://soundcloud.com/jwagener",
      "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"
    },
    "tracks": [
      {
        "id": 6621631,
        "created_at": "2010/11/02 09:08:43 +0000",
        "user_id": 3207,
        "duration": 27099,
        "commentable": true,
        "state": "finished",
        "sharing": "public",
        "tag_list": "Fieldrecording geo:lat=52.527544 geo:lon=13.402905",
        "permalink": "coffee-machine",
        "description": "",
        "streamable": true,
        "downloadable": true,
        "genre": "",
        "release": "",
        "purchase_url": null,
        "label_id": null,
        "label_name": "",
        "isrc": "",
        "video_url": null,
        "track_type": "",
        "key_signature": "",
        "bpm": null,
        "title": "coffee machine",
        "release_year": null,
        "release_month": null,
        "release_day": null,
        "original_format": "wav",
        "license": "cc-by",
        "uri": "http://api.soundcloud.com/tracks/6621631",
        "permalink_url": "http://soundcloud.com/jwagener/coffee-machine",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002863219-4zpxc0-large.jpg?142a848",
        "waveform_url": "http://w1.sndcdn.com/Yva1Qimi7TVd_m.png",
        "user": {
          "id": 3207,
          "permalink": "jwagener",
          "username": "Johannes Wagener",
          "uri": "http://api.soundcloud.com/users/3207",
          "permalink_url": "http://soundcloud.com/jwagener",
          "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"
        },
        "stream_url": "http://api.soundcloud.com/tracks/6621631/stream",
        "download_url": "http://api.soundcloud.com/tracks/6621631/download",
        "playback_count": 436,
        "download_count": 40,
        "favoritings_count": 9,
        "comment_count": 0,
        "created_with": {
          "id": 64,
          "name": "FiRe - Field Recorder",
          "uri": "http://api.soundcloud.com/apps/64",
          "permalink_url": "http://soundcloud.com/apps/fire"
        },
        "attachments_uri": "http://api.soundcloud.com/tracks/6621631/attachments"
      },
      {
        "id": 6621549,
        "created_at": "2010/11/02 09:00:23 +0000",
        "user_id": 3207,
        "duration": 65618,
        "commentable": true,
        "state": "finished",
        "sharing": "public",
        "tag_list": "Fieldrecording geo:lat=52.528181 geo:lon=13.412658",
        "permalink": "tram-in-berlin",
        "description": "",
        "streamable": true,
        "downloadable": true,
        "genre": "",
        "release": "",
        "purchase_url": null,
        "label_id": null,
        "label_name": "",
        "isrc": "",
        "video_url": null,
        "track_type": "recording",
        "key_signature": "",
        "bpm": null,
        "title": "tram in berlin",
        "release_year": null,
        "release_month": null,
        "release_day": null,
        "original_format": "wav",
        "license": "cc-by",
        "uri": "http://api.soundcloud.com/tracks/6621549",
        "permalink_url": "http://soundcloud.com/jwagener/tram-in-berlin",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002863163-6f2aqe-large.jpg?142a848",
        "waveform_url": "http://w1.sndcdn.com/u04ibjx6FYdM_m.png",
        "user": {
          "id": 3207,
          "permalink": "jwagener",
          "username": "Johannes Wagener",
          "uri": "http://api.soundcloud.com/users/3207",
          "permalink_url": "http://soundcloud.com/jwagener",
          "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"
        },
        "stream_url": "http://api.soundcloud.com/tracks/6621549/stream",
        "download_url": "http://api.soundcloud.com/tracks/6621549/download",
        "playback_count": 231,
        "download_count": 36,
        "favoritings_count": 3,
        "comment_count": 1,
        "created_with": {
          "id": 64,
          "name": "FiRe - Field Recorder",
          "uri": "http://api.soundcloud.com/apps/64",
          "permalink_url": "http://soundcloud.com/apps/fire"
        },
        "attachments_uri": "http://api.soundcloud.com/tracks/6621549/attachments"
      },
      {
        "id": 6668072,
        "created_at": "2010/11/03 19:47:11 +0000",
        "user_id": 3207,
        "duration": 21871,
        "commentable": true,
        "state": "finished",
        "sharing": "public",
        "tag_list": "geo:lat=52.527529 geo:lon=13.402961",
        "permalink": "alex-playing-drums",
        "description": "",
        "streamable": true,
        "downloadable": true,
        "genre": null,
        "release": "",
        "purchase_url": null,
        "label_id": null,
        "label_name": "",
        "isrc": "",
        "video_url": null,
        "track_type": "recording",
        "key_signature": "",
        "bpm": null,
        "title": "alex playing drums",
        "release_year": null,
        "release_month": null,
        "release_day": null,
        "original_format": "wav",
        "license": "cc-by",
        "uri": "http://api.soundcloud.com/tracks/6668072",
        "permalink_url": "http://soundcloud.com/jwagener/alex-playing-drums",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002888918-takbu6-large.jpg?142a848",
        "waveform_url": "http://w1.sndcdn.com/MQnxWxIH94ai_m.png",
        "user": {
          "id": 3207,
          "permalink": "jwagener",
          "username": "Johannes Wagener",
          "uri": "http://api.soundcloud.com/users/3207",
          "permalink_url": "http://soundcloud.com/jwagener",
          "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"
        },
        "stream_url": "http://api.soundcloud.com/tracks/6668072/stream",
        "download_url": "http://api.soundcloud.com/tracks/6668072/download",
        "playback_count": 179,
        "download_count": 35,
        "favoritings_count": 1,
        "comment_count": 1,
        "created_with": {
          "id": 64,
          "name": "FiRe - Field Recorder",
          "uri": "http://api.soundcloud.com/apps/64",
          "permalink_url": "http://soundcloud.com/apps/fire"
        },
        "attachments_uri": "http://api.soundcloud.com/tracks/6668072/attachments"
      },
      {
        "id": 6698933,
        "created_at": "2010/11/04 19:09:32 +0000",
        "user_id": 3207,
        "duration": 12726,
        "commentable": true,
        "state": "finished",
        "sharing": "public",
        "tag_list": "geo:lat=52.528450 geo:lon=13.404099",
        "permalink": "typing",
        "description": "",
        "streamable": true,
        "downloadable": true,
        "genre": null,
        "release": "",
        "purchase_url": null,
        "label_id": null,
        "label_name": "",
        "isrc": "",
        "video_url": null,
        "track_type": "recording",
        "key_signature": "",
        "bpm": null,
        "title": "typing",
        "release_year": null,
        "release_month": null,
        "release_day": null,
        "original_format": "wav",
        "license": "cc-by",
        "uri": "http://api.soundcloud.com/tracks/6698933",
        "permalink_url": "http://soundcloud.com/jwagener/typing",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002903990-le6t7d-large.jpg?142a848",
        "waveform_url": "http://w1.sndcdn.com/ZSil4IqhP6Hh_m.png",
        "user": {
          "id": 3207,
          "permalink": "jwagener",
          "username": "Johannes Wagener",
          "uri": "http://api.soundcloud.com/users/3207",
          "permalink_url": "http://soundcloud.com/jwagener",
          "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"
        },
        "stream_url": "http://api.soundcloud.com/tracks/6698933/stream",
        "download_url": "http://api.soundcloud.com/tracks/6698933/download",
        "playback_count": 132,
        "download_count": 29,
        "favoritings_count": 0,
        "comment_count": 0,
        "created_with": {
          "id": 64,
          "name": "FiRe - Field Recorder",
          "uri": "http://api.soundcloud.com/apps/64",
          "permalink_url": "http://soundcloud.com/apps/fire"
        },
        "attachments_uri": "http://api.soundcloud.com/tracks/6698933/attachments"
      },
      {
        "id": 6770077,
        "created_at": "2010/11/07 02:45:11 +0000",
        "user_id": 3207,
        "duration": 27202,
        "commentable": true,
        "state": "finished",
        "sharing": "public",
        "tag_list": "geo:lat=52.531203 geo:lon=13.412165",
        "permalink": "bassy",
        "description": "",
        "streamable": true,
        "downloadable": true,
        "genre": "",
        "release": "",
        "purchase_url": null,
        "label_id": null,
        "label_name": "",
        "isrc": "",
        "video_url": null,
        "track_type": "recording",
        "key_signature": "",
        "bpm": null,
        "title": "bassy",
        "release_year": null,
        "release_month": null,
        "release_day": null,
        "original_format": "wav",
        "license": "cc-by",
        "uri": "http://api.soundcloud.com/tracks/6770077",
        "permalink_url": "http://soundcloud.com/jwagener/bassy",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002938592-960ejc-large.jpg?142a848",
        "waveform_url": "http://w1.sndcdn.com/bxaiyNJt3vWK_m.png",
        "user": {
          "id": 3207,
          "permalink": "jwagener",
          "username": "Johannes Wagener",
          "uri": "http://api.soundcloud.com/users/3207",
          "permalink_url": "http://soundcloud.com/jwagener",
          "avatar_url": "http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"
        },
        "stream_url": "http://api.soundcloud.com/tracks/6770077/stream",
        "download_url": "http://api.soundcloud.com/tracks/6770077/download",
        "playback_count": 160,
        "download_count": 20,
        "favoritings_count": 0,
        "comment_count": 1,
        "created_with": {
          "id": 64,
          "name": "FiRe - Field Recorder",
          "uri": "http://api.soundcloud.com/apps/64",
          "permalink_url": "http://soundcloud.com/apps/fire"
        },
        "attachments_uri": "http://api.soundcloud.com/tracks/6770077/attachments"
      }
    ]
  }
  JS
  playlist: <<-JS.gsub(/\s+/, " "),
  {
    "id": 405726,
    "tracks": [
      {
        "id": 6668072,
        "downloadable": true,
        "title": "alex playing drums",
        "original_format": "wav",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002888918-takbu6-large.jpg?142a848",
        "download_url": "http://api.soundcloud.com/tracks/6668072/download"
      },
      {
        "id": 6698933,
        "downloadable": true,
        "title": "typing",
        "original_format": "wav",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002903990-le6t7d-large.jpg?142a848",
        "download_url": "http://api.soundcloud.com/tracks/6698933/download"
      },
      {
        "id": 6770077,
        "downloadable": true,
        "title": "bassy",
        "original_format": "wav",
        "artwork_url": "http://i1.sndcdn.com/artworks-000002938592-960ejc-large.jpg?142a848",
        "download_url": "http://api.soundcloud.com/tracks/6770077/download"
      }
    ]
  }
  JS

  group: <<-JS.gsub(/\s+/, " "),
  {
    "id": 3,
    "created_at": "2009/06/18 15:46:46 +0000",
    "permalink": "made-with-ableton-live",
    "name": "Made with Ableton Live!",
    "short_description": "tracks produced with Ableton Live! music software, no DJ mixes!",
    "description": "send your tracks, no DJ mixes please!",
    "uri": "http://api.soundcloud.com/groups/3",
    "artwork_url": "http://i1.sndcdn.com/artworks-000000481400-f0ynk3-large.jpg?142a848",
    "permalink_url": "http://soundcloud.com/groups/made-with-ableton-live",
    "creator": {
      "id": 1433,
      "permalink": "matas",
      "username": "matas",
      "uri": "http://api.soundcloud.com/users/1433",
      "permalink_url": "http://soundcloud.com/matas",
      "avatar_url": "http://i1.sndcdn.com/avatars-000001548772-zay6dy-large.jpg?142a848"
    }
  }
  JS

}

RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }

STUBS = Faraday::Adapter::Test::Stubs.new do |stub|
  stub.get('/me/playlists') { [200, RESPONSE_HEADERS.dup, "[#{SAMPLES[:playlist]}]"] }
  stub.get('/me/playlists?offset=50') { [200, RESPONSE_HEADERS.dup, "[#{SAMPLES[:playlist]},#{SAMPLES[:playlist]}]"] }
  stub.get('/me/tracks?filter=downloadable&offset=0') { [200, RESPONSE_HEADERS.dup, "[#{SAMPLES[:track]}]"] }
  stub.get('/playlists/405726') { [200, RESPONSE_HEADERS.dup, "#{SAMPLES[:playlist]}"] }
  stub.get('/me/followings?offset=0') { [200, RESPONSE_HEADERS.dup, "[#{SAMPLES[:user]}]"] }
  stub.get('/users/1234/playlists?offset=0') { [200, RESPONSE_HEADERS.dup, "[#{SAMPLES[:playlist]},#{SAMPLES[:playlist]}]"] }
  %w"playlist%5Btitle%5D=test%20set&playlist%5Bsharing%5D=public&
       playlist%5Btitle%5D=test%20set&playlist%5Bsharing%5D=public
       playlist%5Bsharing%5D=public&playlist%5Btitle%5D=test%20set&".each do |body|
    stub.post("/playlists", body) do
      [201, RESPONSE_HEADERS.dup, SAMPLES[:playlist].dup]
    end
  end
  stub.delete("/playlists/405726") {[200, RESPONSE_HEADERS.dup, ""]}
  stub.post "/tracks" do
    [201, RESPONSE_HEADERS.dup, SAMPLES[:track].dup]
  end
  stub.put("/playlists/405726") {[200, RESPONSE_HEADERS.dup, ""]}
  stub.get("/tracks/13158665") { [200, RESPONSE_HEADERS.dup, "#{SAMPLES[:track]}"] }
  stub.get("/me/favorites?filter=downloadable&offset=0") { [200, RESPONSE_HEADERS.dup, JSON.dump(JSON.parse(SAMPLES[:playlist])["tracks"])] }
  stub.get("/me/favorites?filter=downloadable&offset=50") { [200, RESPONSE_HEADERS.dup, JSON.dump(JSON.parse(SAMPLES[:playlist])["tracks"])] }
  stub.put("/me/favorites/13158665") { [200, RESPONSE_HEADERS.dup, "#{SAMPLES[:track]}"] }
  stub.get("/tracks") { [200, RESPONSE_HEADERS.dup, "[#{SAMPLES[:track]}]"] }
  stub.get("/tracks/123") { [200, RESPONSE_HEADERS.dup, "#{SAMPLES[:track]}"] }
  stub.get("/tracks/124") { [404, RESPONSE_HEADERS.dup, "{'error': 'not found', 'status': 404}"] }
  stub.get("/users/bleh/playlists") { [503, {}, "{'error': 'service unavailable', 'status': 503}"] }
  stub.get("/users/haproxy_error/playlists") do [503, {'Content-Type' => 'text/html'}, <<-HTML]
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    <html lang="en">
    <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <title>We were unable to process your request in time - SoundCloud</title>
    </head>
    <body>
    <div id="maintenance">
    <h1> Yikes, we were unable <br /> to process your request <br /> in time. </h1>
    <span> Please reload the page or try again in a moment. </span>
    </div>
    </body>
    </html>
    HTML
  end
end
