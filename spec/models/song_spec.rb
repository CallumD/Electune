require_relative '../../app/models/song'

describe Song, "#voting" do

  let(:song) { FactoryGirl.create(:song) }
  let(:user) { FactoryGirl.create(:user) }

  it "should have one vote when created" do
    song.votes.should eq(1)
  end

  it "should only allow upvoting when it has at least one vote" do
    song.veto song.user.id
    song.upvote song.user.id
    song.votes.should eq(0)
  end

  it "should only allow vetoing when it has at least one vote" do
    song.veto user.id
    song.votes.should eq(0)
  end

  it "should increase the votes when upvoted" do
    song.upvote user.id
    song.votes.should eq(2)
  end

  it "should decreate the votes when vetoed" do
   song.upvote FactoryGirl.create(:user).id
   song.veto user.id
   song.votes.should eq(1)
  end

  it "should allow duplicate name" do
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
    song.votes.should eq(1)
    song.upvote user.id
    song.votes.should eq(2)
  end

  it "should be able to veto a song" do
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
   song.upvote user.id
   user.upvoted_songs.should include song
  end

  it "should have the same number of users as upvoters" do
   song.upvote song.user.id
   song.upvoters.should have(1).User
  end

  it "should only allow single upvotement from user" do
   song.upvote song.user.id
   song.upvotements.should have(1).Upvotement
   song.upvote song.user.id
   song.upvotements.should have(1).Upvotement
  end

  it "should only allow single upvote from user" do
   song = FactoryGirl.create(:song)
   song.upvote song.user.id
   song.votes.should eq(1)
   song.upvote song.user.id
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

  it { should respond_to(:already_vetoed_by_user?) }

  it "should return false if not vetoed by user" do
     song = FactoryGirl.create(:song)
     non_vetoed_user = FactoryGirl.create(:user)
     song.already_vetoed_by_user?(non_vetoed_user.id).should eq false
  end

  it "should return true if not upvoted by user" do
     song = FactoryGirl.create(:song)
     song.veto song.user.id
     song.already_vetoed_by_user?(song.user.id).should eq true
  end
end
