class Upvotement < ActiveRecord::Base
  attr_accessible :song_id, :upvoter_id

  belongs_to :song
  belongs_to :upvoter, class_name: "User"
end
