require 'spec_helper'

describe SpotifySongSearch, 'the spotify search helper' do
  describe 'the track name search' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_service_response).and_return('tracks' => [{
        'name' => 'name', 'length' => 3600, 'href' => 'test.link', 'album' => { 'availability' => { 'territories' => 'GB' },
          'name' => 'album_name', 'released' => '2012-12-01 09:04:35', 'href' => 'album.link' },
          'artists' => [{ 'name' => 'artist_name', 'href' => 'artist.link' }] }
      ])
    end

    let(:result) { SpotifySongSearch.perform_search 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_search('this has spaces') }.not_to raise_error
    end

    it 'returns an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns a single result as per the stub' do
      expect(result.size).to eq(1)
    end

    it 'contains a song' do
      expect(result.first).to be_a_kind_of Song
    end

    it 'has a song name' do
      expect(result.first.name).to eq 'name'
    end

    it 'should be a big decimal' do
      expect(result.first.length).to be_a_kind_of BigDecimal
    end

    it 'has a spotify link' do
      expect(result.first.link).to eq 'test.link'
    end

    describe 'the songs album' do
      it 'has an album' do
        expect(result.first.album).to be_a_kind_of Album
      end

      it 'has a name' do
        expect(result.first.album.name).to eq 'album_name'
      end

      it 'has a released date' do
        expect(result.first.album.release_date).to eq '2012-12-01 09:04:35'
      end

      it 'has a spotify link' do
        expect(result.first.album.link).to eq 'album.link'
      end
    end

    describe 'a song songs artists' do
      it 'should be an array' do
        expect(result.first.artists.to_a).to be_a_kind_of Array
      end

      it 'has the one stubbed artist' do
        expect(result.first.artists.size).to eq 1
      end

      it 'has an artist in the collection' do
        expect(result.first.artists.first).to be_a_kind_of Artist
      end

      it 'has a name' do
        expect(result.first.artists.first.name).to eq 'artist_name'
      end

      it 'has a spotify link' do
        expect(result.first.artists.first.link).to eq 'artist.link'
      end
    end
  end

  describe 'search by artist' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_service_response).and_return('artists' => [{ 'name' => 'name', 'href' => 'test.link' }])
    end

    let(:result) { SpotifySongSearch.perform_search_by_artist 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_search_by_artist('this has spaces') }.not_to raise_error
    end

    it 'should return an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns a single result as per the stub' do
      expect(result.size).to eq(1)
    end

    it 'contains an artist' do
      expect(result.first).to be_a_kind_of Artist
    end

    it 'has a name' do
      expect(result.first.name).to eq 'name'
    end

    it 'has a spotify link' do
      expect(result.first.link).to eq 'test.link'
    end
  end

  describe 'lookup by artist' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_url_response).and_return('artist' => { 'albums' => [{ 'album' => { 'availability' => { 'territories' => 'GB' }, 'name' => 'album_name', 'released' => '2012-12-01 09:04:35', 'href' => 'album.link' } }] })
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_artist 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_lookup_by_artist('this has spaces') }.not_to raise_error
    end

    it 'returns an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns a single result as per the stub' do
      expect(result.size).to eq(1)
    end

    it 'contains an artist' do
      expect(result.first).to be_a_kind_of Album
    end

    it 'has a name' do
      expect(result.first.name).to eq 'album_name'
    end

    it 'has a released date' do
      expect(result.first.release_date).to eq '2012-12-01 09:04:35'
    end

    it 'has a spotify link' do
      expect(result.first.link).to eq 'album.link'
    end
  end

  describe 'lookup by album' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_url_response).and_return('album' => { 'availability' => { 'territories' => 'GB' }, 'name' => 'album_name', 'released' => '2012-12-01 09:04:35', 'href' => 'album.link', 'tracks' => [{ 'name' => 'name', 'length' => 3600, 'href' => 'test.link', 'artists' => [{ 'name' => 'name', 'href' => 'test.link' }] }] })
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_album 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_lookup_by_album('this has spaces') }.not_to raise_error
    end

    it 'returns an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns a single result as per the stub' do
      expect(result.size).to eq(1)
    end

    it 'contains an artist' do
      expect(result.first).to be_a_kind_of Song
    end

    it 'has a name' do
      expect(result.first.name).to eq 'name'
    end

    it 'has a length' do
      expect(result.first.length).to eq 3600
    end

    it 'has a spotify link' do
      expect(result.first.link).to eq 'test.link'
    end
  end

  describe 'it should reject songs that are not playable in the GB region' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_service_response).and_return('tracks' => [
        {
          'name' => 'name2', 'length' => 3600, 'href' => 'test2.link',
          'album' => { 'availability' => { 'territories' => 'AD' }, 'name' => 'album_name', 'released' => '2012-12-01 09:04:35', 'href' => 'album.link' },
          'artists' => [{ 'name' => 'artist_name', 'href' => 'artist.link' }]
        }, {
          'name' => 'name', 'length' => 3600, 'href' => 'test.link',
          'album' => { 'availability' => { 'territories' => 'GB' }, 'name' => 'album_name', 'released' => '2012-12-01 09:04:35', 'href' => 'album.link' },
          'artists' => [{ 'name' => 'artist_name', 'href' => 'artist.link' }]
        }])
    end

    let(:result) { SpotifySongSearch.perform_search 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_search('this has spaces') }.not_to raise_error
    end

    it 'returns an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns the gb result only' do
      expect(result.size).to eq(1)
    end

    it 'contains a song' do
      expect(result.first).to be_a_kind_of Song
    end

    it 'has the song name of the gb result' do
      expect(result.first.name).to eq 'name'
    end
  end

  describe 'it should reject songs that are not playable in the GB region when doing lookup by album' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_url_response).and_return('album' => {
        'availability' => { 'territories' => 'AU' },
        'name'         => 'album_name',
        'released'     => '2012-12-01 09:04:35',
        'href'         => 'album.link',
        'tracks'       => [
          { 'name' => 'name2', 'length' => 3600, 'href' => 'test2.link', 'artists' => [{ 'name' => 'name', 'href' => 'test.link' }] },
          { 'name' => 'name', 'length' => 600, 'href' => 'test.link', 'artists' => [{ 'name' => 'name', 'href' => 'test.link' }] }
        ]})
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_album 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_lookup_by_album('this has spaces') }.not_to raise_error
    end

    it 'returns an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns no results as the album isnt available in the GB region' do
      expect(result.size).to eq(0)
    end
  end

  describe 'lookup by artist should reject ablums not available in GB' do
    before(:each) do
      allow(SpotifySongSearch).to receive(:get_url_response).and_return('artist' => {
        'albums' => [
          'album' => { 'availability' => { 'territories' => 'AU' }, 'name' => 'album_name', 'released' => '2012-12-01 09:04:35', 'href' => 'album.link' }
        ]})
    end

    let(:result) { SpotifySongSearch.perform_lookup_by_artist 'this_is_something_that_does_not_matter' }

    it 'should not throw error when passed spaces in query' do
      expect { SpotifySongSearch.perform_lookup_by_artist('this has spaces') }.not_to raise_error
    end

    it 'returns an array' do
      expect(result).to be_a_kind_of Array
    end

    it 'returns any results as the album is unavailable in GB' do
      expect(result.size).to eq(0)
    end
  end
end
