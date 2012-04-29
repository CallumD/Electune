class Song < ActiveRecord::Base

  belongs_to :playlist
  attr_accessible :votes,:playlist_name

  def after_initialize
    @votes = 1
  end

  def upvote
    @votes += 1
  end

  def vito
    @votes -= 1
  end
end
