class Artist < ActiveRecord::Base
  attr_accessible :name, :spotify_link
  validates_uniqueness_of :spotify_link
end
