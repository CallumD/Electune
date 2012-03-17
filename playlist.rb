class Playlist
  def initialize
   @songs = Array.new
  end
  
  def count
    @songs.count
  end

  def push song
    @songs.push song
  end

  def shift
    @songs.shift
  end
  
  def delete song
    @songs.delete song
  end

  def include? song
    @songs.include? song
  end
end
