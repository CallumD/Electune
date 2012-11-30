class Playlist < ActiveRecord::Base

  attr_accessible :name
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
    self.playlist_items.delete playlist_item
    playlist_item
  end

  def include? playlist_item
    self.playlist_items.include? playlist_item
  end

  private
    def default_values
      self.playlist_items ||= Array.new
    end
end
