class Artist
  include Mongoid::Document
  field :name, type: String
  field :spotify_link, type: String
  attr_accessible :name, :spotify_link
  validates_uniqueness_of :spotify_link
end
