require 'spec_helper'

describe SongsController do

let (:song) { FactoryGirl.create(:song, votes: 2) }
let (:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe "upvote a song with Ajax" do
    it "should increment votes count" do
      expect do
        xhr :post, :upvote, {id: song.id}
      end.to change{ Song.find(song.id).votes }.by(1)
    end

    it "should respond with success" do
      xhr :post, :upvote, {id: song.id}
      response.should be_success
    end
  end

  describe "veto a song with Ajax" do
    it "should decrement votes count" do
      expect do
        xhr :post, :veto, {id: song.id}
      end.to change{ Song.find(song.id).votes }.by(-1)
    end

    it "should respond with success" do
      xhr :post, :veto, {id: song.id}
      response.should be_success
    end
  end
end
