class Song < ActiveRecord::Base

  belongs_to :playlist
  has_many :upvotements, dependent: :destroy
  has_many :upvoters, through: :upvotements, source: :upvoter
  has_many :vetoments, dependent: :destroy
  has_many :vetoers, through: :vetoments, source: :vetoer
  attr_accessible :name

  validates_format_of :name, :with => /(\w)+/i

  after_initialize :default_values

  def default_values
   logger.info "Called after_initialize"
   self.votes ||= 1
  end

  def upvote user_id
    upvotements.find_or_create_by_upvoter_id(user_id)
    self.votes += 1 unless self.votes <= 0
    save
  end

  def veto user_id
    vetoments.find_or_create_by_vetoer_id(user_id)
    self.votes -= 1 unless self.votes <= 0
    checkremove
    save
  end

  private
    def checkremove
      if self.votes == 0
        self.playlist.delete self unless self.playlist.nil?
      end
    end
end
