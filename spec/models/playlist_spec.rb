require_relative '../../app/models/playlist'
require_relative '../../app/models/playlist_item'

describe Playlist, "#playlist_items" do

  let(:playlist) { FactoryGirl.build(:playlist) }

  it "should be empty when first initialised" do
    playlist.count.should eq(0)
  end

  it "should add to playlist_items via
  playlist" do
    playlist.push(FactoryGirl.build(:playlist_item))
    playlist.count.should eq(1)
  end

  it "should remove playlist_item when played" do
    playlist_item = FactoryGirl.build(:playlist_item)
    playlist.push(playlist_item)
    playlist.shift.should eq(playlist_item)
    playlist.count.should eq(0)
  end

  it "should preserve the order in which the playlist_items are added" do
    addThreePlaylistItems
    playlist_item_one = PlaylistItem.find_by_name 'one'
    playlist_item_two = PlaylistItem.find_by_name 'two'
    playlist_item_three = PlaylistItem.find_by_name 'three'
    playlist.shift.should eq(playlist_item_one)
    playlist.shift.should eq(playlist_item_two)
    playlist.shift.should eq(playlist_item_three)
  end

  it "should be possible to remove a playlist_item" do
    addThreePlaylistItems
    playlist_item_to_remove = PlaylistItem.find_by_name 'two'
    playlist.delete(playlist_item_to_remove).should eq(playlist_item_to_remove)
    playlist.count.should eq(2)
    playlist.include?('two').should eq(false)
  end

  it "should remove playlist_item with 0 votes" do
    user = FactoryGirl.create(:user)
    playlist_item = FactoryGirl.build(:playlist_item)
    playlist.push(playlist_item)
    playlist.fetch(playlist_item).votes.should eq(1)
    playlist_item.veto user.id
    playlist.include?(playlist_item).should eq(false)
  end

  it "should not delete the playlist_item just the relationship" do
    user = FactoryGirl.create(:user)
    playlist_item = FactoryGirl.create(:playlist_item)
    playlist.push(playlist_item)
    playlist_item_id = playlist_item.id
    playlist_item.veto user.id
    PlaylistItem.find(playlist_item_id).should eq(playlist_item)
  end

  it "should not allow duplicate name" do
    FactoryGirl.create(:playlist)
    duplicate = FactoryGirl.build(:playlist)
    duplicate.should_not be_valid
  end

  private
    def addThreePlaylistItems
      playlist.push(FactoryGirl.build(:playlist_item, name: 'one'))
      playlist.push(FactoryGirl.build(:playlist_item, name: 'two'))
      playlist.push(FactoryGirl.build(:playlist_item, name: 'three'))
    end
end
