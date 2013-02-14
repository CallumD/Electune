class Upvotement
  include Mongoid::Document
  
  attr_accessible :playlist_item_id, :upvoter_id

  belongs_to :playlist_item
  belongs_to :upvoter, class_name: "User"
end
