class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @first = nil
    @last = nil
    @links = []
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @first
  end

  def last
    @last
  end

  def empty?
    @links.empty?
  end

  def get(key)
    target_link = find { |link| link.key == key }
    target_link.nil? ? nil : target_link.val
  end

  def include?(key)
    !!get(key)
  end

  def insert(key, val)
    new_link = Link.new(key,val)

    if first.nil?
      @first = new_link
      @last = new_link
    else
      self.last.next = new_link
      new_link.prev = self.last
      @last = new_link
    end

    @links << new_link
    # new_link
  end

  def remove(key)
    target_link = find { |link| link.key == key }

    if @last == target_link
      target_link.prev.next = nil
      @last = target_link.prev
    else
      target_link.next.prev = target_link.prev
    end

    if @first == target_link
      target_link.next.prev = nil
      @first = target_link.next
    else
      target_link.prev.next = target_link.next
    end

    @links.delete(target_link)
  end

  def remove_link(link)
    if @last == link
      link.prev.next = nil
      @last = link.prev
    else
      link.next.prev = link.prev
    end

    if @first == link
      link.next.prev = nil
      @first = link.next
    else
      link.prev.next = link.next
    end
    @links << link
  end

  def each(&prc)
    @links.each(&prc)
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  def remove_first
    @first.next.prev = nil
    @links.shift
  end
end
