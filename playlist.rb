class Playlist
  def initialize
   @songs = Array.new
  end

  def vito song
    if @songs.include? song
     song.vito 
     checkremove song
    end
  end

  def checkremove song
    if song.votes == 0
      delete song
    end
  end

  def upvote song
    if @songs.include? song
      song.upvote
    end
  end
  
  def fetch song
    @songs.fetch(@songs.index(song))
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
