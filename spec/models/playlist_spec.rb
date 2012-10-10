require_relative '../../app/models/playlist'
require_relative '../../app/models/song'

describe Playlist, "#songs" do

  let(:playlist) { playlist = Playlist.create }

  it "should be empty when first initialised" do
    playlist.count.should eq(0)
  end

  it "should add to songs via playlist" do
    playlist.push(Song.new)
    playlist.count.should eq(1)
  end  

  it "should remove song when played" do
    song = Song.create!(name: "songOne")
    playlist.push(song)
    playlist.shift.should eq(song)
    playlist.count.should eq(0)
  end

  it "should preserve the order in which the songs are added" do
    addThreeSongs
    song_one = Song.find_by_name "one"
    song_two = Song.find_by_name "two"
    song_three = Song.find_by_name "three"
    playlist.shift.should eq(song_one)
    playlist.shift.should eq(song_two)
    playlist.shift.should eq(song_three)
  end

  it "should be possible to remove a song" do
    addThreeSongs
    song_to_remove = Song.find_by_name "two"
    playlist.delete(song_to_remove).should eq(song_to_remove)
    playlist.count.should eq(2)
    playlist.include?("two").should eq(false)
  end

  it "should be able to upvote a song" do
    song = Song.new
    playlist.push(song)
    playlist.fetch(song).votes.should eq(1)
    playlist.upvote song
    playlist.fetch(song).votes.should eq(2)
  end
  
  it "should be able to vito a song" do
    song = Song.new
    playlist.push(song)
    playlist.fetch(song).votes.should eq(1)
    playlist.upvote song
    playlist.fetch(song).votes.should eq(2)
    playlist.vito song
    playlist.fetch(song).votes.should eq(1)
  end

  it "should remove song with 0 votes" do
    song = Song.new
    playlist.push(song)
    playlist.fetch(song).votes.should eq(1)
    playlist.vito song
    playlist.include?(song).should eq(false)
  end
  def addThreeSongs
    playlist.push(Song.create(name: "one"))
    playlist.push(Song.create(name: "two"))
    playlist.push(Song.create(name: "three"))
  end
end
