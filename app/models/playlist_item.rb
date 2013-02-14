class PlaylistItem
  include Mongoid::Document

  belongs_to :playlist
  has_many :upvotements
  has_many :vetoments
  belongs_to :song
  belongs_to :user


  attr_accessible :song, :user

  after_create :default_values

  def default_values
    self.upvote self.user._id
  end

  def already_upvoted_by_user? user_id
    user = User.find user_id
    upvoters.include? user
  end

  def already_vetoed_by_user? user_id
    user = User.find user_id
    vetoers.include? user
  end

  def votes
   upvotements.count - vetoments.count
  end

  def upvote user_id
    upvotements.create(upvoter_id: user_id) unless upvotements.where(upvoter_id: user_id).exists?
  end

  def veto user_id
    vetoments.find_or_create_by(vetoer_id: user_id) unless self.votes <= 0
    checkremove
  end

  def upvoters
    upvotements.map(&:upvoter)
  end

  def vetoers
    vetoments.map(&:vetoer)
  end

  private
    def checkremove
      if votes == 0
        self.playlist.delete self unless self.playlist.nil?
      end
    end
end
