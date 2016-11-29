class PlaylistItem < ActiveRecord::Base
  belongs_to :playlist
  has_many :upvotements, dependent: :destroy
  has_many :upvoters, through: :upvotements, source: :upvoter
  has_many :vetoments, dependent: :destroy
  has_many :vetoers, through: :vetoments, source: :vetoer
  belongs_to :song
  belongs_to :user

  after_create :default_values

  def default_values
    upvote user.id
  end

  def already_upvoted_by_user?(user_id)
    user = User.find user_id
    upvoters.include? user
  end

  def already_vetoed_by_user?(user_id)
    user = User.find user_id
    vetoers.include? user
  end

  def votes
    upvotements.count - vetoments.count
  end

  def upvote(user_id)
    upvotements.find_or_create_by(upvoter_id: user_id)
  end

  def veto(user_id)
    vetoments.find_or_create_by(vetoer_id: user_id) unless votes <= 0
    checkremove
  end

  private
  def checkremove
    if playlist.playlist_items.first != self
      playlist.delete self if votes.zero?
    end
  end
end
