require_relative '../../app/helpers/spotify_track_search'

describe SpotifyTrackSearch, "description" do

  before(:each) do
    SpotifyTrackSearch.stub(:get_service_response).and_return({'tracks' => [{'name'=> 'name', 'length' => 3600, 'href' => 'test.link', 'album' => {'name' => 'album_name', 'released' => 'today', 'href' => 'album.link'}, 'artists' => [{'name' => 'artist_name', 'href' => 'artist.link'}]}]})
  end

  let(:result) { SpotifyTrackSearch.perform_search "this_is_something_that_does_not_matter" }

  it "should not throw error when passed spaces in query" do
    lambda { SpotifyTrackSearch.perform_search("this has spaces")}.should_not raise_error
  end

  it "should return an array" do
    result.should be_a_kind_of Array
  end

  it "should return a single result as per the stub" do
    result.size.should eq(1)
  end

  it "should contain a track" do
    result.first.should be_a_kind_of Track
  end

  it "should have a track name" do
    result.first.name.should eq 'name'
  end

  it "should have a formatted time" do
    result.first.length.should match /\d{2}:\d{2}/
  end

  it "should have a spotify link" do
    result.first.spotify_link.should eq 'test.link'
  end

  describe "the tracks album" do
    it "should have an album" do
      result.first.album.should be_a_kind_of Album
    end

    it "should have a name" do
      result.first.album.name.should eq 'album_name'
    end

    it "should have a released date" do
      result.first.album.release_date.should eq 'today'
    end

    it "should have a spotify link" do
      result.first.album.spotify_link.  should eq 'album.link'
    end
  end

  describe "a track tracks artists" do
    it "should be an array" do
      result.first.artists.should be_a_kind_of Array
    end

    it "should only have the one stubbed artist" do
      result.first.artists.size.should eq 1
    end

    it "should only have an artist in the collection" do
      result.first.artists.first.should be_a_kind_of Artist
    end

    it "should have a name" do
      result.first.artists.first.name.should eq 'artist_name'
    end

    it "should have a spotify link" do
      result.first.artists.first.spotify_link.should eq 'artist.link'
    end
  end
end
