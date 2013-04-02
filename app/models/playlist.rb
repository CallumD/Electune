class Playlist < ActiveRecord::Base

  attr_accessible :name, :start_time
  has_many :playlist_items
  after_initialize :default_values
  validates :name, :uniqueness => { :case_sensitive => false }

  def fetch playlist_item
    PlaylistItem.find playlist_item
  end

  def count
    playlist_items.count
  end

  def push playlist_item
    playlist_item.playlist = self
    playlist_item.save
    playlist_item
  end

  def shift
    playlist_item = playlist_items.shift
    delete playlist_item
    insert_random_song if count == 0 
    playlist_item
  end

  def delete playlist_item
    playlist_items.delete playlist_item
    playlist_item
  end

  def include? playlist_item
    playlist_items.include? playlist_item
  end

  def tick
    if Time.now > start_time + playlist_items.first.song.length.to_f
     update_attributes(start_time: (start_time + playlist_items.first.song.length))
     shift
    end
    Time.now - start_time
  end

  private
    def insert_random_song
      item = playlist_items.create(song: Song.random, user: User.random)
      update_attributes(start_time: Time.now) if playlist_items.count == 1
      push item 
    end

    def default_values
      playlist_items ||= Array.new
    end
end
