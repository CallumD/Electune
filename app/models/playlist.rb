class Playlist < ActiveRecord::Base

  attr_accessible :name
  has_many :songs
  after_initialize :default_values
  validates :name, :uniqueness => { :case_sensitive => false }
  
  def fetch song
    Song.find song
  end
  
  def count
    self.songs.count
  end

  def push song
    song.playlist = self
    song.save
    song
  end

  def shift
    song = self.songs.shift
    Song.delete(song)
    song
  end
  
  def delete song
    self.songs.delete song
    Song.delete song
    song
  end

  def include? song
    self.songs.include? song
  end

  private
    def default_values
      self.songs ||= Array.new
    end
end
