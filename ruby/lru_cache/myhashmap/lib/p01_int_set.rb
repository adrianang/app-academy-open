class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise ArgumentError.new("Out of bounds") if !self.is_valid?(num)
    @store[num] = true if self.is_valid?(num)
  end

  def remove(num)
    @store[num] = false if self.include?(num)
  end

  def include?(num)
    @store[num] == true ? true : false
  end

  def is_valid?(num)
    (0..@max).to_a.include?(num) ? true : false
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if !self.include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    self[num].include?(num) ? true : false
  end

  private
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self.resize! if @count == self.num_buckets

    if !self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num) ? true : false
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(self.num_buckets * 2) { Array.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each do |num|
        self.insert(num)
      end
    end
  end
end

# The time complexities for inserting, deleting, and checking for inclusion in ResizingIntSet is O(1), since resizing the store allows us to amortize time.