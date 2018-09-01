require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash

    sum = 0
    self.each_with_index do |el, i|
      sum += el.hash * i.hash
    end
    sum
  end
end

class String
  def hash
    arr = self.split("").map do |el|
      el.ord
    end
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |k,v|
      arr << v.hash
    end
    arr.sort.hash
  end
end
