class Song < ActiveRecord::Base

  belongs_to :playlist
  attr_accessible :votes, :name, :playlist
  
  validates_format_of :name, :with => /(\w)+/i

  after_initialize :default_values
  
  def default_values
   logger.info "Called after_initialize"
   self.votes ||= 1
  end

  def upvote
    self.votes += 1
    save
  end

  def vito
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
