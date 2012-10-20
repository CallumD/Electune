require 'spec_helper'

describe SongsController do

let (:song) { Song.create name: "test", votes: 2 }

  describe "upvote a song with Ajax" do
    it "should increment votes count" do
      expect do
        xhr :post, :upvote, {id: song.id}
      end.to change{ song.votes }.by(1)
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
      end.to change{ song.votes }.by(1)
    end

    it "should respond with success" do
      xhr :post, :veto, {id: song.id}
      response.should be_success
    end
  end
end

