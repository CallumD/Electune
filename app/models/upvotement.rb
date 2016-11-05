class Upvotement < ActiveRecord::Base
  belongs_to :playlist_item
  belongs_to :upvoter, class_name: 'User'
end
