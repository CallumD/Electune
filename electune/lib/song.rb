class Song
  attr_reader :votes

  def initialize
    @votes = 1
  end

  def upvote
    @votes += 1
  end

  def vito
    @votes -= 1
  end
end
