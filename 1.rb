class Array
  def sizes
    self.nil? ? 0 : self.size
  end
end
p [1, 2, 3].sizes
