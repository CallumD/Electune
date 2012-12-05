class Album < ActiveRecord::Base
  attr_accessible :name, :release_date, :spotify_link
  has_many :songs
  validates_uniqueness_of :spotify_link
end
