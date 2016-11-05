module ActiveRandom
  def random
    offset = rand(count)
    offset(offset).first
  end
end
