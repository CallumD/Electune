class Performer
  include Mongoid::Document
  belongs_to :artist
  belongs_to :song
end
