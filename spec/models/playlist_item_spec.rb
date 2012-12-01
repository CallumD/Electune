require_relative '../../app/models/playlist_item'

describe PlaylistItem, "#voting" do

  let(:playlist_item) { FactoryGirl.create(:playlist_item) }
  let(:user) { FactoryGirl.create(:user) }

  it "should have one vote when created" do
    playlist_item.votes.should eq(1)
  end

  it "should only allow upvoting when it has at least one vote" do
    playlist_item.veto playlist_item.user.id
    playlist_item.upvote playlist_item.user.id
    playlist_item.votes.should eq(0)
  end

  it "should only allow vetoing when it has at least one vote" do
    playlist_item.veto user.id
    playlist_item.votes.should eq(0)
  end

  it "should increase the votes when upvoted" do
    playlist_item.upvote user.id
    playlist_item.votes.should eq(2)
  end

  it "should decreate the votes when vetoed" do
   playlist_item.upvote FactoryGirl.create(:user).id
   playlist_item.veto user.id
   playlist_item.votes.should eq(1)
  end

  it "should persist an upvote" do
    playlist_item = FactoryGirl.create(:playlist_item)
    playlist_item.upvote user.id
    from_database = PlaylistItem.find playlist_item.id
    from_database.votes.should eq(2)
  end

  it "should be able to upvote a playlist_item" do
    playlist_item.votes.should eq(1)
    playlist_item.upvote user.id
    playlist_item.votes.should eq(2)
  end

  it "should be able to veto a playlist_item" do
    playlist_item.votes.should eq(1)
    playlist_item.upvote user.id
    playlist_item.veto user.id
    playlist_item.votes.should eq(1)
  end

  it { should respond_to(:upvoters) }
  it { should respond_to(:upvotements) }

  it "should register user when upvoted" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.upvote user.id
   playlist_item.upvoters.should include user
  end

  it "should register playlist_item when upvoted" do
   playlist_item.upvote user.id
   user.upvoted_playlist_items.should include playlist_item
  end

  it "should have the same number of users as upvoters" do
   playlist_item.upvote playlist_item.user.id
   playlist_item.upvoters.should have(1).User
  end

  it "should only allow single upvotement from user" do
   playlist_item.upvote playlist_item.user.id
   playlist_item.upvotements.should have(1).Upvotement
   playlist_item.upvote playlist_item.user.id
   playlist_item.upvotements.should have(1).Upvotement
  end

  it "should only allow single upvote from user" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.upvote playlist_item.user.id
   playlist_item.votes.should eq(1)
   playlist_item.upvote playlist_item.user.id
   playlist_item.votes.should eq(1)
  end

  it { should respond_to(:vetoers) }
  it { should respond_to(:vetoments) }

  it "should register user when vetoed" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.veto user.id
   playlist_item.vetoers.should include user
  end

  it "should register playlist_item when vetoed" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.veto user.id
   user.vetoed_playlist_items.should include playlist_item
  end

  it "should have the same number of users as vetoers" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.veto user.id
   playlist_item.vetoers.should have(1).User
  end

  it "should only allow single veto from user" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.veto user.id
   playlist_item.vetoments.should have(1).Upvotement
   playlist_item.veto user.id
   playlist_item.vetoments.should have(1).Upvotement
  end

  it "should only allow single veto from user" do
   playlist_item = FactoryGirl.create(:playlist_item)
   playlist_item.veto user.id
   playlist_item.votes.should eq(0)
   playlist_item.veto user.id
   playlist_item.votes.should eq(0)
  end

  it { should respond_to(:already_vetoed_by_user?) }

  it "should return false if not vetoed by user" do
     playlist_item = FactoryGirl.create(:playlist_item)
     non_vetoed_user = FactoryGirl.create(:user)
     playlist_item.already_vetoed_by_user?(non_vetoed_user.id).should eq false
  end

  it "should return true if not upvoted by user" do
     playlist_item = FactoryGirl.create(:playlist_item)
     playlist_item.veto playlist_item.user.id
     playlist_item.already_vetoed_by_user?(playlist_item.user.id).should eq true
  end
end
