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
    playlist.shift.should eq("one")
    playlist.shift.should eq("two")
    playlist.shift.should eq("three")
  end

  it "should be possible to remove a song" do
    addThreeSongs
    playlist.delete(Song.new(name: "two")).should eq(Song.new(name: "two"))
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
    playlist.push(Song.new(name: "one"))
    playlist.push(Song.new(name: "two"))
    playlist.push(Song.new(name: "three"))
  end
end
