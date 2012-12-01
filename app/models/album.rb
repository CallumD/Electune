class Album < ActiveRecord::Base
  attr_accessible :name, :release_date, :spotify_link
  has_many :songs
end
