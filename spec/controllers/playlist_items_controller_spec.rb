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
end
