module ActiveRandom
  def random
    offset = rand(self.count)
    self.first(:offset => offset)
  end
end
