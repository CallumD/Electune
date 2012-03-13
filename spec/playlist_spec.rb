require_relative '../playlist'

describe Playlist, "#songs" do
  it "should be empty when first initialised" do
    playlist = Playlist.new
    playlist.songs.count.should eq(0)
  end
end
