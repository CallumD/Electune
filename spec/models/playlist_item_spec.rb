require_relative '../../app/models/playlist_item'

describe PlaylistItem, '#voting' do
  let(:playlist_item) { FactoryGirl.create(:playlist_item) }
  let(:user) { FactoryGirl.create(:user) }

  it 'has one vote when created' do
    expect(playlist_item.votes).to eq(1)
  end

  it 'only allows upvoting when it has at least one vote' do
    playlist_item.veto playlist_item.user.id
    playlist_item.upvote playlist_item.user.id
    expect(playlist_item.votes).to eq(0)
  end

  it 'only allows vetoing when it has at least one vote' do
    playlist_item.veto user.id
    expect(playlist_item.votes).to eq(0)
  end

  it 'increases the votes when upvoted' do
    playlist_item.upvote user.id
    expect(playlist_item.votes).to eq(2)
  end

  it 'decreates the votes when vetoed' do
    playlist_item.upvote create(:user).id
    playlist_item.veto user.id
    expect(playlist_item.votes).to eq(1)
  end

  it 'persists an upvote' do
    playlist_item = create(:playlist_item)
    playlist_item.upvote user.id
    from_database = PlaylistItem.find playlist_item.id
    expect(from_database.votes).to eq(2)
  end

  it 'upvotes a playlist_item' do
    expect(playlist_item.votes).to eq(1)
    playlist_item.upvote user.id
    expect(playlist_item.votes).to eq(2)
  end

  it 'vetos a playlist_item' do
    expect(playlist_item.votes).to eq(1)
    playlist_item.upvote user.id
    playlist_item.veto user.id
    expect(playlist_item.votes).to eq(1)
  end

  it { should respond_to(:upvoters) }
  it { should respond_to(:upvotements) }

  it 'registers user when upvoted' do
    playlist_item = FactoryGirl.create(:playlist_item)
    playlist_item.upvote user.id
    expect(playlist_item.upvoters).to include user
  end

  it 'registers playlist_item when upvoted' do
    playlist_item.upvote user.id
    expect(user.upvoted_playlist_items).to include playlist_item
  end

  it 'has the same number of users as upvoters' do
    playlist_item.upvote playlist_item.user.id
    expect(playlist_item.upvoters.count).to eq 1
  end

  it 'enforces single upvotement from user' do
    playlist_item.upvote playlist_item.user.id
    expect(playlist_item.upvotements.count).to eq(1)
    playlist_item.upvote playlist_item.user.id
    expect(playlist_item.upvotements.count).to eq(1)
  end

  it 'allows single upvote from user' do
    playlist_item = create(:playlist_item)
    playlist_item.upvote playlist_item.user.id
    expect(playlist_item.votes).to eq(1)
    playlist_item.upvote playlist_item.user.id
    expect(playlist_item.votes).to eq(1)
  end

  it { should respond_to(:vetoers) }
  it { should respond_to(:vetoments) }

  it 'registers user when vetoed' do
    playlist_item = create(:playlist_item)
    playlist_item.veto user.id
    expect(playlist_item.vetoers).to include user
  end

  it 'registers playlist_item when vetoed' do
    playlist_item = create(:playlist_item)
    playlist_item.veto user.id
    expect(user.vetoed_playlist_items).to include playlist_item
  end

  it 'has the same number of users as vetoers' do
    playlist_item = create(:playlist_item)
    playlist_item.veto user.id
    expect(playlist_item.vetoers.count).to eq(1)
  end

  it 'allows single veto from user' do
    playlist_item = create(:playlist_item)
    playlist_item.veto user.id
    expect(playlist_item.vetoments.count).to eq(1)
    playlist_item.veto user.id
    expect(playlist_item.vetoments.count).to eq(1)
  end

  it 'only allows single veto from user' do
    playlist_item = create(:playlist_item)
    playlist_item.veto user.id
    expect(playlist_item.votes).to eq(0)
    playlist_item.veto user.id
    expect(playlist_item.votes).to eq(0)
  end

  it { should respond_to(:already_vetoed_by_user?) }

  it 'returns false if not vetoed by user' do
    playlist_item = create(:playlist_item)
    non_vetoed_user = create(:user)
    expect(playlist_item.already_vetoed_by_user?(non_vetoed_user.id)).to eq false
  end

  it 'returns true if not upvoted by user' do
    playlist_item = create(:playlist_item)
    playlist_item.veto playlist_item.user.id
    expect(playlist_item.already_vetoed_by_user?(playlist_item.user.id)).to eq true
  end
end
