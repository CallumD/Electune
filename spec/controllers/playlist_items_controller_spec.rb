require 'spec_helper'

describe PlaylistItemsController, type: :controller do
  let (:user) { FactoryBot.create(:user) }
  let (:playlist_item) { FactoryBot.create(:playlist_item) }

  before(:each) do
    sign_in user
  end

  describe 'upvote a playlist_item with Ajax' do
    it 'increments votes count' do
      expect do
        post :upvote, params: { id: playlist_item.id }, xhr: true
      end.to change { PlaylistItem.find(playlist_item.id).votes }.by(1)
    end

    it 'responds with success' do
      post :upvote, params: { id: playlist_item.id }, xhr: true
      expect(response).to be_successful
    end
  end

  describe 'veto a playlist_item with Ajax' do
    it 'decrements votes count' do
      expect do
        post :veto, params: { id: playlist_item.id }, xhr: true
      end.to change { PlaylistItem.find(playlist_item.id).votes }.by(-1)
    end

    it 'responds with success' do
      post :veto, params: { id: playlist_item.id }, xhr: true
      expect(response).to be_successful
    end
  end

  describe 'when spotify service call throws an error' do
    before(:each) do
      allow(Song).to receive(:where).and_raise(StandardError.new)
    end
    describe 'index search by artist name' do
      it 'has a flash mentioning there hase been an error' do
        get :index, params: {
          artist: 'this does not matter',
          playlist_id: FactoryBot.create(:playlist)
        }, xhr: true
        assert_template :service_error
      end
      it 'doesnt raise the exception' do
        expect { get :index, params: { artist: 'this does not matter', playlist_id: FactoryBot.create(:playlist) }, xhr: true }.not_to raise_error
      end
    end

    describe 'artist lookup' do
      it 'has a flash mentioning there hase been an error' do
        get :artist_lookup, params: { search: 'this does not matter', playlist_id: FactoryBot.create(:playlist) }, xhr: true
        assert_template :service_error
      end
      it 'does not raise the exception' do
        expect { get :artist_lookup, params: { search: 'this does not matter', playlist_id: FactoryBot.create(:playlist) }, xhr: true }.not_to raise_error
      end
    end

    describe 'album lookup' do
      it 'has a flash mentioning there hase been an error' do
        get :album_lookup, params: { search: 'this does not matter', playlist_id: FactoryBot.create(:playlist) }, xhr: true
        assert_template :service_error
      end
      it 'doesnt raise the exception' do
        expect { get :album_lookup, params: { search: 'this does not matter', playlist_id: FactoryBot.create(:playlist) }, xhr: true }.not_to raise_error
      end
    end
  end
end
