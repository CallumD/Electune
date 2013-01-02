require 'spec_helper'

describe PlaylistItemsController do

let (:user) { FactoryGirl.create(:user) }
let (:playlist_item) { FactoryGirl.create(:playlist_item) }

  before(:each) do
    sign_in user
  end

  describe "upvote a playlist_item with Ajax" do
    it "should increment votes count" do
      expect do
        xhr :post, :upvote, {id: playlist_item.id}
      end.to change{ PlaylistItem.find(playlist_item.id).votes }.by(1)
    end

    it "should respond with success" do
      xhr :post, :upvote, {id: playlist_item.id}
      response.should be_success
    end
  end

  describe "veto a playlist_item with Ajax" do
    it "should decrement votes count" do
      expect do
        xhr :post, :veto, {id: playlist_item.id}
      end.to change{ PlaylistItem.find(playlist_item.id).votes }.by(-1)
    end

    it "should respond with success" do
      xhr :post, :veto, {id: playlist_item.id}
      response.should be_success
    end
  end

  describe "when spotify service call throws an error" do
    before(:each) do
      SpotifySongSearch.stub(:open).and_raise(OpenURI::HTTPError.new nil, nil)
    end
    describe "index search by track name" do
      it "should have a flash mentioning there hase been an error" do
        xhr :get, :index, search: "this does not matter", playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it "it should not raise the exception" do
        assert_nothing_raised { xhr :get, :index, search: "this does not matter", playlist_id: FactoryGirl.create(:playlist) }
      end
    end

    describe "index search by artist name" do
      it "should have a flash mentioning there hase been an error" do
        xhr :get, :index, artist: "this does not matter", playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it "it should not raise the exception" do
        assert_nothing_raised { xhr :get, :index, artist: "this does not matter", playlist_id: FactoryGirl.create(:playlist) }
      end
    end

    describe "artist lookup" do
      it "should have a flash mentioning there hase been an error" do
        xhr :get, :artist_lookup, search: "this does not matter", playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it "it should not raise the exception" do
        assert_nothing_raised { xhr :get, :artist_lookup, search: "this does not matter", playlist_id: FactoryGirl.create(:playlist) }
      end
    end

    describe "album lookup" do
      it "should have a flash mentioning there hase been an error" do
        xhr :get, :album_lookup, search: "this does not matter", playlist_id: FactoryGirl.create(:playlist)
        assert_template :service_error
      end
      it "it should not raise the exception" do
        assert_nothing_raised { xhr :get, :album_lookup, search: "this does not matter", playlist_id: FactoryGirl.create(:playlist) }
      end
    end

  end
end
