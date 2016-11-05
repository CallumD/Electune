class Artist < ActiveRecord::Base
  validates_uniqueness_of :spotify_link
end
