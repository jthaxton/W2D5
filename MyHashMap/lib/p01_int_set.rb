require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {Array.new}
  end

  def insert(num)
    if num > @store.length || num <= 0
      raise "Out of bounds"
    else
      @store[num - 1] << num
    end
  end

  def remove(num)
    @store[num - 1].pop
  end

  def include?(num)
    if @store[num - 1][0] == num
      true
    else
      false
    end
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num % @store.length
    @store[idx] += [num] unless self.include?(num)
  end

  def remove(num)
    @store.each do |bucket|
      bucket.delete(num) if bucket.include?(num)
    end
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include?(num)
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    idx = num % @store.length
    unless self.include?(num)
      @store[idx] += [num]
      @count += 1
    end
    resize! if @count > num_buckets
  end

  def remove(num)
    @store.each do |bucket|
      if bucket.include?(num)
        bucket.delete(num)
        @count -= 1
      end
    end
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include?(num)
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    temp_store = []
    @store.each do |bucket|
      temp_store += bucket
    end
    # p temp_store

    @store = Array.new(num_buckets * 2) {[]}
    @count = 0

    temp_store.each do |num|
      insert(num)
    end
  end
end
