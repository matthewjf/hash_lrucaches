require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(obj)
    @count+=1
    resize! if @count > num_buckets
    self[obj] << obj
  end

  def remove(obj)
    if self.include?(obj)
      self[obj].delete(obj)
      @count-=1
    end
  end

  def include?(obj)
    self[obj].include?(obj)
  end

  private

  def [](obj)
    @store[obj.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_ary = @store.map { |el| el.dup }

    @store = Array.new(2 * num_buckets) { Array.new }

    @count=1
    old_ary.flatten.each do |obj|
      insert(obj)
    end
  end
end
