describe "API conformity" do
  before do
    @item = {id: 123}
    @other = {id: 456}
  end

  subject { Soundcloud::API.new("fake", verbose: false, stubs: STUBS) }

  [
    [:users, "/users"],
    [:user, "/users/123"],
    [:user_tracks, "/users/123/tracks"],
    [:user_playlists, "/users/123/playlists"],
    [:user_groups, "/users/123/groups"],
    [:user_web_profiles, "/users/123/web-profiles"],
    [:user_followings, "/users/123/followings"],
    [:follow!, "/users/me/followings/123", :put],
    [:follow?, "/users/456/followings/123"],
    [:unfollow!, "/users/me/followings/123", :delete],
    [:user_followers, "/users/123/followers"],
    [:user_comments, "/users/123/comments"],
    [:user_favorites, "/users/123/favorites"],
    [:favorite!, "/users/me/favorites/123", :put],
    [:favorite?, "/users/456/favorites/123"],
    [:unfavorite!, "/users/me/favorites/123", :delete],
    [:user_connections, "/users/123/connections"],
    [:user_activities, "/users/123/activities"],
    [:tracks, "/tracks"],
    [:track, "/tracks/123"],
    [:create_track, "/tracks", :post],
    [:update_track, "/tracks/123", :put],
    [:delete_track, "/tracks/123", :delete],
    [:track_comments, "/tracks/123/comments"],
    [:track_favoriters, "/tracks/123/favoriters"],
    [:track_shared_to_users, "/tracks/123/shared-to/users"],
    [:track_shared_to_emails, "/tracks/123/shared-to/emails"],
    [:track_secret_token, "/tracks/123/secret-token"],
    [:playlists, "/playlists"],
    [:playlist, "/playlists/123"],
    [:create_playlist, "/playlists", :post],
    [:update_playlist, "/playlists/123", :put],
    [:delete_playlist, "/playlists/123", :delete],
    [:playlist_shared_to_users, "/playlists/123/shared-to/users"],
    [:playlist_shared_to_emails, "/playlists/123/shared-to/emails"],
    [:playlist_secret_token, "/playlists/123/secret-token"],
    [:groups, "/groups"],
    [:group, "/groups/123"],
    [:create_group, "/groups", :post],
    [:update_group, "/groups/123", :put],
    [:delete_group, "/groups/123", :delete],
    [:group_moderators, "/groups/123/moderators"],
    [:group_members, "/groups/123/members"],
    [:group_contributors, "/groups/123/contributors"],
    [:group_users, "/groups/123/users"],
    [:group_tracks, "/groups/123/tracks"],
    [:group_pending_tracks, "/groups/123/pending-tracks"],
    [:group_contributions, "/groups/123/contributions"],
    [:comments, "/comments"],
    [:comment, "/comments/123"],
    [:apps, "/apps"],
    [:app, "/apps/123"],
    [:app_tracks, "/apps/123/tracks"]
  ].each do |meth, path, verb=nil|
    verb ||= :get
    describe meth do
      last_param = Soundcloud::API.instance_method(meth).parameters.last
      if last_param == [:opt, :opts]
        it "should #{verb.upcase} #{path} (when not given options)" do
          subject.should_receive(verb).with(path, {}).and_return(mock(:response, body: nil))
          subject.send meth, *[@item, @other].take(subject.method(meth).arity.abs)
        end
        it "should #{verb.upcase} #{path}?some=option (when given options)" do
          subject.should_receive(verb).with(path, {:some=>"option"}).and_return(mock(:response, body: nil))
          subject.send meth, *[@item, @other].take(subject.method(meth).arity.abs), {some: "option"}
        end
      else
        it "should #{verb.upcase} #{path}" do
          subject.stub!(verb).with(path).and_return(mock(:response, body: nil))
          subject.stub!(verb).with(path, instance_of(Hash)).and_return(mock(:response, body: nil))
          subject.send meth, *[@item, @other].take(subject.method(meth).arity.abs)
        end
      end
      if last_param == [:opt, :who]
        default_path = path.gsub("456", "me")
        it "should #{verb.upcase} #{default_path} (when the :who param is not given)" do
          subject.should_receive(verb).with(default_path).and_return(mock(:response, body: nil))
          subject.send meth, *[@item, @other].take(subject.method(meth).arity.abs - 1)
        end
      end
    end
  end
end
