require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    delete(key) if include?(key)

    @count+=1
    resize! if @count > num_buckets
    bucket(key).insert(key,val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count-=1
    bucket(key).remove(key)
  end

  def each(&prc)
    @store.each{|ll| ll.each { |link| prc.call(link.key, link.val) } }
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    key_vals = []
    @store.each do |ll|
      ll.each do |link|
        key_vals << [link.key, link.val]
      end
    end

    @store = Array.new(2 * num_buckets) { LinkedList.new }

    @count=1

    key_vals.each do |key, val|
      set(key, val)
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
