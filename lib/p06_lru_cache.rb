require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @map[key] = @store.insert(key, @prc.call(key) )
    eject! if count > max
  end

  def update_link!(link)
    link.next.prev = link.prev
    link.prev.next = link.next
    @store.last.next = link
    link.next = nil
    link.prev = @store.last
    @store.last = link
  end

  def eject!
    @map.remove(@store.remove_first)
  end
end
