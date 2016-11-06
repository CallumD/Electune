class Album < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  validates_uniqueness_of :link
end
