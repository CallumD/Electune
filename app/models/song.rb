class Song < ActiveRecord::Base
  belongs_to :album
  has_many :performers
  has_many :artists, through: :performers

  attr_accessible :length, :name, :spotify_link

  validates_format_of :name, :with => /(\w)+/i
  validates_uniqueness_of :spotify_link
end
