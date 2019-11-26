require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.bucket(key).include?(key) ? true : false
  end

  def set(key, val)
    self.resize! if @count == self.num_buckets

    if self.bucket(key).include?(key)
      self.bucket(key).update(key, val)
    else
      self.bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    self.bucket(key).get(key)
  end

  def delete(key)
    self.bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
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

  # private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    self.expand

    old_store.each do |bucket|
      bucket.each do |node|
        self.set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % self.num_buckets]
  end

  def expand
    @store = Array.new(self.num_buckets * 2) { LinkedList.new }
    @count = 0
  end
end
