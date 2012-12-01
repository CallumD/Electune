class Performer < ActiveRecord::Base
  attr_accessible :artist_id, :song_id
  belongs_to :artist
  belongs_to :song
end
