class Vetoment < ActiveRecord::Base
  attr_accessible :playlist_item_id, :vetoer_id

  belongs_to :playlist_item
  belongs_to :vetoer, class_name: 'User'
end
