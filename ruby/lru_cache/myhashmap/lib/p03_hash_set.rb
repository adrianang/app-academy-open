class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self.resize! if @count == self.num_buckets

    if !self[key].include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key) ? true : false
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end    
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(self.num_buckets * 2) { Array.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each do |ele|
        self.insert(ele)
      end
    end
  end
end
