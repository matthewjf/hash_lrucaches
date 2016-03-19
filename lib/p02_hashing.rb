class Fixnum

end

class Array
  def hash

    map.with_index { |el,i| i.hash ^ el.hash }.inject(0) do |result,el|
      result * 1000 + el

    end.hash
  end
end

class String
  def hash
    result = 0
    self.chars.each do |char|
      result = result * 1000 + char.ord
    end
    result.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
