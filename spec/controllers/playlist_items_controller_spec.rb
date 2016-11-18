require 'spec_helper'

describe PlaylistItemsController, type: :controller do
  let (:user) { FactoryGirl.create(:user) }
  let (:playlist_item) { FactoryGirl.create(:playlist_item) }

  before(:each) do
    sign_in user
  end

  describe 'upvote a playlist_item with Ajax' do
    it 'increments votes count' do
      expect do
        xhr :post, :upvote, id: playlist_item.id
      end.to change { PlaylistItem.find(playlist_item.id).votes }.by(1)
    end

    it 'responds with success' do
      xhr :post, :upvote, id: playlist_item.id
      expect(response).to be_success
    end
  end

  describe 'veto a playlist_item with Ajax' do
    it 'decrements votes count' do
      expect do
        xhr :post, :veto, id: playlist_item.id
      end.to change { PlaylistItem.find(playlist_item.id).votes }.by(-1)
    end

    it 'responds with success' do
      xhr :post, :veto, id: playlist_item.id
      expect(response).to be_success
    end
  end

  describe 'when spotify service call throws an error' do
    before(:each) do
      allow(Song).to receive(:where).and_raise(StandardError.new)
    end
    describe 'index search by artist name' do
      it 'has a flash mentioning there hase been an error' do
        xhr :get, :index, artist: 'this does not matter', playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it 'doesnt raise the exception' do
        expect { xhr :get, :index, artist: 'this does not matter', playlist_id: FactoryGirl.create(:playlist) }.not_to raise_error
      end
    end

    describe 'artist lookup' do
      it 'has a flash mentioning there hase been an error' do
        xhr :get, :artist_lookup, search: 'this does not matter', playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it 'does not raise the exception' do
        expect { xhr :get, :artist_lookup, search: 'this does not matter', playlist_id: FactoryGirl.create(:playlist) }.not_to raise_error
      end
    end

    describe 'album lookup' do
      it 'has a flash mentioning there hase been an error' do
        xhr :get, :album_lookup, search: 'this does not matter', playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it 'doesnt raise the exception' do
        expect { xhr :get, :album_lookup, search: 'this does not matter', playlist_id: FactoryGirl.create(:playlist) }.not_to raise_error
      end
    end
  end
end
