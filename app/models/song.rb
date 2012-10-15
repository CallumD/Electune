class Song < ActiveRecord::Base

  belongs_to :playlist
  attr_accessible :votes, :name
    validates :name, :uniqueness => { :case_sensitive => false }
     validates_format_of :name, :with => /(\w)+/i

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
