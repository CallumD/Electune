module ActiveRandom
  def random
    offset = rand(count)
    first(offset: offset)
  end
end
