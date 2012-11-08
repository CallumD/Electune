class Song < ActiveRecord::Base

  belongs_to :playlist
  has_many :upvotements, dependent: :destroy
  has_many :upvoters, through: :upvotements, source: :upvoter
  has_many :vetoments, dependent: :destroy
  has_many :vetoers, through: :vetoments, source: :vetoer
  belongs_to :user
  attr_accessible :name

  after_create :default_values

  def default_values
    self.upvote self.user.id
  end

  validates_format_of :name, :with => /(\w)+/i

  def votes
   upvotements.count - vetoments.count
  end

  def upvote user_id
    upvotements.find_or_create_by_upvoter_id(user_id)
  end

  def veto user_id
    vetoments.find_or_create_by_vetoer_id(user_id) unless self.votes <= 0
    checkremove
  end

  private
    def checkremove
      if votes == 0
        self.playlist.delete self unless self.playlist.nil?
      end
    end
end
