class Playlist < ActiveRecord::Base

  attr_accessible :name
  has_many :songs
  after_initialize :default_values

  def vito song
    if self.songs.include? song
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
    if self.songs.include? song
      song.upvote
    end
  end
  
  def fetch song
    self.songs.fetch(self.songs.index(song))
  end
  
  def count
    self.songs.count
  end

  def push song
    self.songs.push song
  end

  def shift
    song = self.songs.shift
    Song.delete(song)
    song
  end
  
  def delete song
    self.songs.delete song
  end

  def include? song
    self.songs.include? song
  end

  private
    def default_values
      self.songs ||= Array.new
    end
end
