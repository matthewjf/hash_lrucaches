class MaxIntSet
  def initialize(max)
    @max = max
    @store=Array.new(max,false)
  end

  def insert(int)
    @store[int]=true
  end

  def remove(int)
    @store[int]=false
  end

  def include?(int)
    @store[int]
  end

end
