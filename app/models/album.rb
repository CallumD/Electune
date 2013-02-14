class Album
  include Mongoid::Document

  field :name, type: String
  field :release_date, type: Time
  field :spotify_link, type: String
  attr_accessible :name, :release_date, :spotify_link
  has_many :songs
  validates_uniqueness_of :spotify_link
end
