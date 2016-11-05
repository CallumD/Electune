require_relative '../../app/models/playlist'
require_relative '../../app/models/playlist_item'

describe Playlist, '#playlist_items' do
  let(:playlist) { FactoryGirl.build(:playlist) }

  it 'adds a song when the playlist empties' do
    playlist.push(FactoryGirl.build(:playlist_item))
    playlist.shift
    playlist.count.should eq(1)
    playlist.shift
    playlist.count.should eq(1)
  end

  it 'should be empty when first initialised' do
    playlist.count.should eq(0)
  end

  it "should add to playlist_items via
  playlist" do
    playlist.push(FactoryGirl.build(:playlist_item))
    playlist.count.should eq(1)
  end

  it 'should remove playlist_item when played' do
    playlist_item = FactoryGirl.build(:playlist_item)
    playlist.push(playlist_item)
    playlist.shift.should eq(playlist_item)
    playlist.playlist_items.should_not include(playlist_item)
  end

  it 'should have a start_time' do
    playlist = FactoryGirl.build(:playlist)
    playlist.should respond_to :start_time
  end

  it 'should preserve the order in which the playlist_items are added' do
    one = FactoryGirl.build(:playlist_item)
    two = FactoryGirl.build(:playlist_item)
    three = FactoryGirl.build(:playlist_item)
    playlist.push(one)
    playlist.push(two)
    playlist.push(three)
    playlist.shift.should eq(one)
    playlist.shift.should eq(two)
    playlist.shift.should eq(three)
  end

  it 'should be possible to remove a playlist_item' do
    one = FactoryGirl.build(:playlist_item)
    two = FactoryGirl.build(:playlist_item)
    playlist_item_to_remove = FactoryGirl.build(:playlist_item)
    playlist.push(one)
    playlist.push(two)
    playlist.push(playlist_item_to_remove)
    playlist.delete(playlist_item_to_remove).should eq(playlist_item_to_remove)
    playlist.count.should eq(2)
    playlist.include?(playlist_item_to_remove).should eq(false)
  end

  it 'should remove playlist_item with 0 votes' do
    user = FactoryGirl.create(:user)
    playlist_item = FactoryGirl.build(:playlist_item)
    playlist.push(playlist_item)
    playlist.fetch(playlist_item).votes.should eq(1)
    playlist_item.veto user.id
    playlist.include?(playlist_item).should eq(false)
  end

  it 'should not delete the playlist_item just the relationship' do
    user = FactoryGirl.create(:user)
    playlist_item = FactoryGirl.create(:playlist_item)
    playlist.push(playlist_item)
    playlist_item_id = playlist_item.id
    playlist_item.veto user.id
    PlaylistItem.find(playlist_item_id).should eq(playlist_item)
  end

  it 'should not allow duplicate name' do
    FactoryGirl.create(:playlist, name: 'test')
    duplicate = FactoryGirl.build(:playlist, name: 'test')
    duplicate.should_not be_valid
  end

  describe 'tick will shift songs up the playlist' do
    before(:each) do
      @playlist = FactoryGirl.create(:playlist, start_time: '12/12/12 12:12:12')
      @song = FactoryGirl.create(:song)
      @user = FactoryGirl.create(:user)
      @playlist.playlist_items.create(song: @song, user: @user)
      @playlist.playlist_items.create(song: @song, user: @user)
    end

    describe 'when the current time is less than the song time' do
      before(:each) do
        Time.stub(:current).and_return(Time.new(12, 12, 12, 12, 12, 30))
      end
      it 'should not shift the song off the playlist' do
        count = @playlist.playlist_items.count
        @playlist.tick
        @playlist.playlist_items.count.should eq count
      end
      it 'should report the time as the difference between the start time and the current time' do
        difference = Time.current - @playlist.start_time
        response = @playlist.tick
        response.should eq difference
      end
    end

    describe 'when the current time is more than the song time' do
      before(:each) do
        Time.stub(:current).and_return(Time.new(12, 12, 12, 12, 13, 30))
      end
      it 'should shift the current song off the playlist' do
        count = @playlist.playlist_items.count
        @playlist.tick
        @playlist.playlist_items.count.should eq(count - 1)
      end

      it 'should set the playlist start time to the previous start time plus the song shiftpeds length' do
        expected_time = @playlist.start_time + @playlist.playlist_items.first.song.length
        @playlist.start_time.should_not eq expected_time
        @playlist.tick
        @playlist.reload
        @playlist.start_time.should eq expected_time
      end

      it 'should report the time as the difference between the start time (less the previous track as it also pops it off) and the current time ' do
        difference = Time.current - @playlist.start_time - @playlist.playlist_items.first.song.length
        response = @playlist.tick
        response.should eq difference
      end
    end
  end

  # |Start_time|---------------------------------------|Start_time + song.length|
  # |Start_time|------------|Current_time|-------------|Start_time + song.length|
  # |Start_time|---------------------------------------|Start_time + song.length|------|Current_time|---------|Start_time + song2.length|
  # |Start_time = Start_time + song.length|------|Current_time|---------|Start_time + song2.length|

  private
  def add_three_playlist_items
    playlist.push(FactoryGirl.build(:playlist_item))
    playlist.push(FactoryGirl.build(:playlist_item))
    playlist.push(FactoryGirl.build(:playlist_item))
  end
end
