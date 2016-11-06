class Album < ActiveRecord::Base
  has_many :songs
  validates_uniqueness_of :link
end
