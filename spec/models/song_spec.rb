require_relative '../../app/models/song'

describe Song, "#voting" do

  let(:song) { FactoryGirl.build(:song) }
  let(:user) { FactoryGirl.create(:user) }

  it "should have one vote when initialised" do
    song.votes.should eq(1)
  end

  it "should only allow upvoting when it has at least one vote" do
    song.veto user.id
    song.upvote user.id
    song.votes.should eq(0)
  end

  it "should only allow vetoing when it has at least one vote" do
    song = FactoryGirl.create(:song)
    song.veto user.id
    song.votes.should eq(0)
  end

  it "should increase the votes when upvoted" do
    song = FactoryGirl.create(:song)
    song.upvote user.id
    song.votes.should eq(2)
  end

  it "should decreate the votes when vetoed" do
   song.upvote FactoryGirl.create(:user).id
   song.veto user.id
   song.votes.should eq(1)
  end

  it "should allow duplicate name" do
    FactoryGirl.create(:song)
    duplicate = FactoryGirl.build(:song)
    duplicate.should be_valid
  end

  it "should not allow empty name" do
    song = FactoryGirl.build(:song, name: '')
    song.should_not be_valid
  end

  it "should not allow name to be blanks" do
    song = FactoryGirl.build(:song, name: '      ')
    song.should_not be_valid
  end

  it "should persist an upvote" do
    song = FactoryGirl.create(:song, name: 'upvote')
    song.upvote user.id
    from_database = Song.find_by_name 'upvote'
    from_database.votes.should eq(2)
  end

  it "should be able to upvote a song" do
    song = FactoryGirl.create(:song)
    song.votes.should eq(1)
    song.upvote user.id
    song.votes.should eq(2)
  end

  it "should be able to veto a song" do
    song = FactoryGirl.create(:song)
    song.votes.should eq(1)
    song.upvote user.id
    song.veto user.id
    song.votes.should eq(1)
  end

  it { should respond_to(:upvoters) }
  it { should respond_to(:upvotements) }

  it "should register user when upvoted" do
   song = FactoryGirl.create(:song)
   song.upvote user.id
   song.upvoters.should include user
  end

  it "should register song when upvoted" do
   song = FactoryGirl.create(:song)
   song.upvote user.id
   user.upvoted_songs.should include song
  end

  it "should have the same number of users as upvoters" do
   song = FactoryGirl.create(:song)
   song.upvote user.id
   song.upvoters.should have(1).User
  end

  it "should only allow single upvotement from user" do
   song = FactoryGirl.create(:song)
   song.upvote user.id
   song.upvotements.should have(1).Upvotement
   song.upvote user.id
   song.upvotements.should have(1).Upvotement
  end

  it "should only allow single upvote from user" do
   song = FactoryGirl.create(:song)
   song.upvote user.id
   song.votes.should eq(1)
   song.upvote user.id
   song.votes.should eq(1)
  end

  it { should respond_to(:vetoers) }
  it { should respond_to(:vetoments) }

  it "should register user when vetoed" do
   song = FactoryGirl.create(:song)
   song.veto user.id
   song.vetoers.should include user
  end

  it "should register song when vetoed" do
   song = FactoryGirl.create(:song)
   song.veto user.id
   user.vetoed_songs.should include song
  end

  it "should have the same number of users as vetoers" do
   song = FactoryGirl.create(:song)
   song.veto user.id
   song.vetoers.should have(1).User
  end

  it "should only allow single veto from user" do
   song = FactoryGirl.create(:song)
   song.veto user.id
   song.vetoments.should have(1).Upvotement
   song.veto user.id
   song.vetoments.should have(1).Upvotement
  end

  it "should only allow single veto from user" do
   song = FactoryGirl.create(:song)
   song.veto user.id
   song.votes.should eq(0)
   song.veto user.id
   song.votes.should eq(0)
  end
end
