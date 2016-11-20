class Playlist < ActiveRecord::Base
  has_many :playlist_items
  after_initialize :default_values
  validates :name, uniqueness: { case_sensitive: false }

  def fetch(playlist_item)
    PlaylistItem.find playlist_item
  end

  delegate :count, to: :playlist_items

  def push(playlist_item)
    playlist_item.playlist = self
    playlist_item.save
    playlist_item
  end

  def shift
    playlist_item = playlist_items.first
    delete playlist_item
    reload
    insert_random_song if playlist_items.count.zero?
    playlist_item
  end

  def delete(playlist_item)
    playlist_items.delete playlist_item
    playlist_item
  end

  delegate :include?, to: :playlist_items

  def tick
    if Time.current > start_time + playlist_items.first.song.length.to_f
      update_attributes(start_time: (start_time + playlist_items.first.song.length))
      shift
    end
    Time.current - start_time
  end

  def insert_random_song
    item = playlist_items.create(song: Song.random, user: User.random)
    update_attributes(start_time: Time.current) if playlist_items.count == 1
    push item
  end

  private
  def default_values
    playlist_items ||= []
  end
end
