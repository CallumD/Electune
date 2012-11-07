class Vetoment < ActiveRecord::Base
  attr_accessible :song_id, :vetoer_id

  belongs_to :song
  belongs_to :vetoer, class_name: "User"
end
