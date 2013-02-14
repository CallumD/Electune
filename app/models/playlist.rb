class Playlist
  include Mongoid::Document
  field :name, type: String
  field :start_time, type: Time
  attr_accessible :name, :start_time
  has_many :playlist_items
  after_initialize :default_values
  validates :name, :uniqueness => { :case_sensitive => false }

  def fetch playlist_item
    PlaylistItem.find playlist_item
  end

  def count
    self.playlist_items.count
  end

  def push playlist_item
    playlist_item.playlist = self
    playlist_item.save
    playlist_item
  end

  def shift
    playlist_item = self.playlist_items.shift
    delete playlist_item
    playlist_item
  end

  def delete playlist_item
    playlist_item.update_attribute(:playlist_id, nil)
    self.playlist_items.delete playlist_item
    playlist_item
  end

  def include? playlist_item
    self.playlist_items.include? playlist_item
  end

  def tick
    if Time.now > start_time + playlist_items.first.song.length.to_f
     update_attributes(start_time: (start_time + playlist_items.first.song.length))
     shift
    end
    Time.now - start_time
  end

  private
    def default_values
      self.playlist_items ||= Array.new
    end
end
