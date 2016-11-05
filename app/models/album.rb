class Album < ActiveRecord::Base
  attr_accessible :name, :release_date, :link
  has_many :songs
  validates_uniqueness_of :link
end
