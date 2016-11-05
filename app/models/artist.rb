class Artist < ActiveRecord::Base
  attr_accessible :name, :link
  validates_uniqueness_of :link
end
