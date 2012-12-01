class Song < ActiveRecord::Base
  belongs_to :album
  has_many :performers
  has_many :artists, through: :performers

  attr_accessible :length, :name, :spotify_link
end
