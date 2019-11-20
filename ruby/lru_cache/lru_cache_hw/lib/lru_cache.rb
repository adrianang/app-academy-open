class LRUCache
  attr_accessor :cache, :accumulator

  def initialize(size)
    @cache = Array.new(size)
    @size = size
  end

  def count
    @cache.count { |ele| ele != nil }
  end

  def add(ele)
    if !@cache.include?(ele)
      @cache.shift
      @cache << ele
    end
    
    if @cache.include?(ele)
      @cache.delete(ele)
      @cache << ele
    end
  end

  def show
    p @cache
  end
end

# Time Complexity
# This solution works fine only when our cache is very small (like 4 in our tests). In real world applications, we would need more than 4 spaces in our cache in cases where an LRU cache is used.
# To improve the efficiency, our cache should be a hash and we should push in nodes that store next and previous keys (that link to other nodes). When updating the order, we would just adjust where the keys point to to account for the new ordering (still following the LRU principle).