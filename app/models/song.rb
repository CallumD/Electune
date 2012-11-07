class Song < ActiveRecord::Base

  belongs_to :playlist
  has_many :upvotements, dependent: :destroy
  has_many :upvoters, through: :upvotements, source: :upvoter
  attr_accessible :name

  validates_format_of :name, :with => /(\w)+/i

  after_initialize :default_values

  def default_values
   logger.info "Called after_initialize"
   self.votes ||= 1
  end

  def upvote by_user
    upvotements.find_or_create_by_upvoter_id(by_user.id)
    self.votes += 1
    save
  end

  def veto
    self.votes -= 1
    checkremove
    save
  end

  private
    def checkremove
      if self.votes == 0
        self.playlist.delete self
      end
    end
end
