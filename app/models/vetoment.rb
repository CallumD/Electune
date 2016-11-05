class Vetoment < ActiveRecord::Base
  belongs_to :playlist_item
  belongs_to :vetoer, class_name: 'User'
end
