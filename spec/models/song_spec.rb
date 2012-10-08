require_relative '../../app/models/song'

describe Song, "#voting" do

  let(:song) { song = Song.create }

  it "should have one vote when initialised" do
    song.votes.should eq(1)
  end
 
  it "should increase the votes when upvoted" do
    song.upvote
    song.votes.should eq(2)
  end

  it "should decreate the votes when vitoed" do
   song.vito
   song.votes.should eq(0)
  end
end


