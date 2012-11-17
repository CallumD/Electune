require_relative '../../app/helpers/spotify_track_search'

describe SpotifyTrackSearch, "description" do
  it "test" do
    spotify_search = double("spotify search")
    spotify_search.stub(:get_service_responce) { "test" }
    SpotifyTrackSearch.stub(:get_service_responce) { spotify_search }
    puts SpotifyTrackSearch.perform_search "test"
  end
end
