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
  
  it "should allow duplicate name" do
    song.name = "test";
    song.save
    duplicate = Song.new(name: "test")
    duplicate.should be_valid
  end
  
  it "should not allow empty name" do
    song = Song.new(name: "")
    song.should_not be_valid
  end
  
  it "should not allow name to be blanks" do
    song = Song.new(name: "     ")
    song.should_not be_valid
  end
  
  it "should persist an upvote" do
    song = Song.create(name: "upvote")
    song.upvote
    from_database = Song.find_by_name "upvote"
    from_database.votes.should eq(2)
  end
end


