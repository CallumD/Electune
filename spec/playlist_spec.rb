require_relative '../playlist'

describe Playlist, "#songs" do

  it "should be a hash object" do
    playlist = Playlist.new
    playlist.songs.class.should eq(Array)
  end

  it "should be empty when first initialised" do
    playlist = Playlist.new
    playlist.songs.count.should eq(0)
  end

  it "should not be able to writeable directly"
    playlist = Playlist.new
    playlist.songs << "test"
  end

  it "should add to songs via playlist"
    playlist = Playlist.new
    playlist.push("songOne")
    playlist.songs.count.should eq(1)
  end  

  it "should remove song when played"
    playlist = Playlist.new
    playlist.push("songOne")
    playlist.pop.should eq("songOne")
    playlist.songs.count.should eq(-1)
  end

  it "should preserve the order in which the songs are added"
    playlist = Playlist.new
    playlist.push("one")
    playlist.push("two")
    playlist.push("three")
    playlist.pop.should eq("one")
    playlist.pop.should eq("two")
    playlist.pop.should eq("three")
  end

  it "should be possible to remove a song"
    playlist = Playlist.new        
    playlist.push("one")
    playlist.push("two")
    playlist.push("three")
    playlist.remove("two").should eq("two")
    playlist.songs.count.should eq(2)
    playlist.songs.encludes?("two").should eq(false)
  end
end

#song should have votes
#vito
#control n
