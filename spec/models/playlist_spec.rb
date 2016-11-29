describe Playlist, '#playlist_items' do
  let(:playlist) { build(:playlist) }

  it 'adds a song when the playlist empties' do
    playlist.push(build(:playlist_item))
    playlist.shift
    expect(playlist.count).to eq(1)
    playlist.shift
    expect(playlist.count).to eq(1)
  end

  it 'should be empty when first initialised' do
    expect(playlist.count).to eq(0)
  end

  it "adds to playlist_items via
  playlist" do
    playlist.push(build(:playlist_item))
    expect(playlist.count).to eq(1)
  end

  it 'removes playlist_item when played' do
    playlist_item = build(:playlist_item)
    playlist.push(playlist_item)
    expect(playlist.shift).to eq(playlist_item)
    expect(playlist.playlist_items).not_to include(playlist_item)
  end

  it 'has a start_time' do
    playlist = build(:playlist)
    expect(playlist).to respond_to :start_time
  end

  it 'preserves the order in which the playlist_items are added' do
    one = build(:playlist_item)
    two = build(:playlist_item)
    three = build(:playlist_item)
    playlist.push(one)
    playlist.push(two)
    playlist.push(three)
    expect(playlist.shift).to eq(one)
    expect(playlist.shift).to eq(two)
    expect(playlist.shift).to eq(three)
  end

  it 'is possible to remove a playlist_item' do
    one = build(:playlist_item)
    two = build(:playlist_item)
    playlist_item_to_remove = build(:playlist_item)
    playlist.push(one)
    playlist.push(two)
    playlist.push(playlist_item_to_remove)
    expect(playlist.delete(playlist_item_to_remove)).to eq(playlist_item_to_remove)
    expect(playlist.count).to eq(2)
    expect(playlist.include?(playlist_item_to_remove)).to eq(false)
  end

  it 'does not remove playlist_item with 0 votes if its the currently playing item' do
    user = create(:user)
    playlist_item = build(:playlist_item)
    playlist.push(playlist_item)
    expect(playlist.fetch(playlist_item).votes).to eq(1)
    playlist_item.veto user.id
    expect(playlist.include?(playlist_item)).to eq(true)
  end

  it 'removes playlist_item with 0 votes if it is not currently playing item' do
    user = create(:user)
    playlist_item = build(:playlist_item)
    playlist.push(playlist_item)
    other_playlist_item = build(:playlist_item, song: build(:song, name: 'b'))
    playlist.push(other_playlist_item)
    expect(playlist.fetch(other_playlist_item).votes).to eq(1)
    other_playlist_item.veto user.id
    expect(playlist.include?(other_playlist_item)).to eq(false)
  end

  it 'doesnt delete the playlist_item just the relationship' do
    user = create(:user)
    playlist_item = create(:playlist_item)
    playlist.push(playlist_item)
    playlist_item_id = playlist_item.id
    playlist_item.veto user.id
    expect(PlaylistItem.find(playlist_item_id)).to eq(playlist_item)
  end

  it 'doesnt allow duplicate name' do
    create(:playlist, name: 'test')
    duplicate = build(:playlist, name: 'test')
    expect(duplicate).not_to be_valid
  end

  describe 'tick will shift songs up the playlist' do
    before(:each) do
      @playlist = create(:playlist, start_time: '12/12/12 12:12:12')
      @song = create(:song)
      @user = create(:user)
      @playlist.playlist_items.create(song: @song, user: @user)
      @playlist.playlist_items.create(song: @song, user: @user)
    end

    describe 'when the current time is less than the song time' do
      before(:each) do
        allow(Time).to receive(:current).and_return(Time.zone.local(12, 12, 12, 12, 12, 30))
      end
      it 'should not shift the song off the playlist' do
        count = @playlist.playlist_items.count
        @playlist.tick
        expect(@playlist.playlist_items.count).to eq count
      end
      it 'reports the time as the difference between the start time and the current time' do
        difference = Time.current - @playlist.start_time
        response = @playlist.tick
        expect(response).to eq difference
      end
    end

    describe 'when the current time is more than the song time' do
      before(:each) do
        allow(Time).to receive(:current).and_return(Time.zone.local(12, 12, 12, 12, 13, 30))
      end
      it 'shifts the current song off the playlist' do
        count = @playlist.playlist_items.count
        @playlist.tick
        expect(@playlist.playlist_items.count).to eq(count - 1)
      end

      it 'sets the playlist start time to the previous start time plus the song shiftpeds length' do
        expected_time = @playlist.start_time + @playlist.playlist_items.first.song.length
        expect(@playlist.start_time).not_to eq expected_time
        @playlist.tick
        @playlist.reload
        expect(@playlist.start_time).to eq expected_time
      end

      it 'reports the time as the difference between the start time (less the previous track as it also pops it off) and the current time ' do
        difference = Time.current - @playlist.start_time - @playlist.playlist_items.first.song.length
        response = @playlist.tick
        expect(response).to eq difference
      end
    end
  end

  # |Start_time|---------------------------------------|Start_time + song.length|
  # |Start_time|------------|Current_time|-------------|Start_time + song.length|
  # |Start_time|---------------------------------------|Start_time + song.length|------|Current_time|---------|Start_time + song2.length|
  # |Start_time = Start_time + song.length|------|Current_time|---------|Start_time + song2.length|

  private
  def add_three_playlist_items
    playlist.push(build(:playlist_item))
    playlist.push(build(:playlist_item))
    playlist.push(build(:playlist_item))
  end
end
