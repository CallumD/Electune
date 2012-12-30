require 'spec_helper'

describe SpotifySongSearch, "the spotify search helper" do
  describe "the track name search" do
    before(:each) do
      SpotifySongSearch.stub(:get_service_response).and_return({'tracks' => [{'name'=> 'name', 'length' => 3600, 'href' => 'test.link', 'album' => {'availability' => {'territories' => 'GB'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link'}, 'artists' => [{'name' => 'artist_name', 'href' => 'artist.link'}]}]})
    end

    let(:result) { SpotifySongSearch.perform_search "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_search("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should return a single result as per the stub" do
      result.size.should eq(1)
    end

    it "should contain a song" do
      result.first.should be_a_kind_of Song
    end

    it "should have a song name" do
      result.first.name.should eq 'name'
    end

    it "should be a big decimal" do
      result.first.length.should be_a_kind_of BigDecimal
    end

    it "should have a spotify link" do
      result.first.spotify_link.should eq 'test.link'
    end

    describe "the songs album" do
      it "should have an album" do
        result.first.album.should be_a_kind_of Album
      end

      it "should have a name" do
        result.first.album.name.should eq 'album_name'
      end

      it "should have a released date" do
        result.first.album.release_date.should eq "2012-12-01 09:04:35"
      end

      it "should have a spotify link" do
        result.first.album.spotify_link.  should eq 'album.link'
      end
    end

    describe "a song songs artists" do
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

  describe "search by artist" do
    before(:each) do
      SpotifySongSearch.stub(:get_service_response).and_return({'artists' => [{'name'=> 'name', 'href' => 'test.link'}]})
    end

    let(:result) { SpotifySongSearch.perform_search_by_artist "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_search_by_artist("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should return a single result as per the stub" do
      result.size.should eq(1)
    end

    it "should contain an artist" do
      result.first.should be_a_kind_of Artist
    end

    it "should have a name" do
      result.first.name.should eq 'name'
    end

    it "should have a spotify link" do
      result.first.spotify_link.should eq 'test.link'
    end
  end

  describe "lookup by artist" do
    before(:each) do
      SpotifySongSearch.stub(:get_url_response).and_return({'artist' => { 'albums' => [{'album' => {'availability' => {'territories' => 'GB'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link'}}]}})
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_artist "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_lookup_by_artist("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should return a single result as per the stub" do
      result.size.should eq(1)
    end

    it "should contain an artist" do
      result.first.should be_a_kind_of Album
    end

    it "should have a name" do
      result.first.name.should eq 'album_name'
    end

    it "should have a released date" do
      result.first.release_date.should eq '2012-12-01 09:04:35'
    end

    it "should have a spotify link" do
      result.first.spotify_link.should eq 'album.link'
    end
  end

  describe "lookup by album" do
    before(:each) do
      SpotifySongSearch.stub(:get_url_response).and_return({'album' => {'availability' => {'territories' => 'GB'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link', 'tracks' => [{'name'=> 'name', 'length' => 3600, 'href' => 'test.link', 'artists' => [{'name'=> 'name', 'href' => 'test.link'}]}]}})
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_album "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_lookup_by_album("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should return a single result as per the stub" do
      result.size.should eq(1)
    end

    it "should contain an artist" do
      result.first.should be_a_kind_of Song
    end

    it "should have a name" do
      result.first.name.should eq 'name'
    end

    it "should have a length" do
      result.first.length.should eq 3600
    end

    it "should have a spotify link" do
      result.first.spotify_link.should eq 'test.link'
    end
  end

  describe "it should reject songs that are not playable in the GB region" do
    before(:each) do
            SpotifySongSearch.stub(:get_service_response).and_return({'tracks' => [{'name'=> 'name2', 'length' => 3600, 'href' => 'test2.link', 'album' => {'availability' => {'territories' => 'AD'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link'}, 'artists' => [{'name' => 'artist_name', 'href' => 'artist.link'}]}, {'name'=> 'name', 'length' => 3600, 'href' => 'test.link', 'album' => {'availability' => {'territories' => 'GB'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link'}, 'artists' => [{'name' => 'artist_name', 'href' => 'artist.link'}]}]})

    end
let(:result) { SpotifySongSearch.perform_search "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_search("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should return the gb result only" do
      result.size.should eq(1)
    end

    it "should contain a song" do
      result.first.should be_a_kind_of Song
    end

    it "should have the song name of the gb result" do
      result.first.name.should eq 'name'
    end
  end

   describe "it should reject songs that are not playable in the GB region when doing lookup by album" do
    before(:each) do
      SpotifySongSearch.stub(:get_url_response).and_return({'album' => {'availability' => {'territories' => 'AU'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link', 'tracks' => [{'name'=> 'name2', 'length' => 3600, 'href' => 'test2.link', 'artists' => [{'name'=> 'name', 'href' => 'test.link'}]}, {'name'=> 'name', 'length' => 600, 'href' => 'test.link', 'artists' => [{'name'=> 'name', 'href' => 'test.link'}]}]}})
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_album "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_lookup_by_album("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should return no results as the album isnt available in the GB region" do
      result.size.should eq(0)
    end
  end

  describe "lookup by artist should reject ablums not available in GB" do
    before(:each) do
      SpotifySongSearch.stub(:get_url_response).and_return({'artist' => { 'albums' => [ 'album' => {'availability' => {'territories' => 'AU'}, 'name' => 'album_name', 'released' => "2012-12-01 09:04:35", 'href' => 'album.link'}]}})
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_artist "this_is_something_that_does_not_matter" }

    it "should not throw error when passed spaces in query" do
      lambda { SpotifySongSearch.perform_lookup_by_artist("this has spaces")}.should_not raise_error
    end

    it "should return an array" do
      result.should be_a_kind_of Array
    end

    it "should not return any results as the album is unavailable in GB" do
      result.size.should eq(0)
    end
  end
end
