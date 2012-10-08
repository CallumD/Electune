class Song < ActiveRecord::Base

  belongs_to :playlist
  attr_accessible :votes,:playlist_id

  after_initialize :default_values

  def default_values
    @votes = 1
  end

  def upvote
    self.votes += 1
  end

  def vito
    self.votes -= 1
  end

  private
    def default_values
      self.votes ||= 1
    end
end
