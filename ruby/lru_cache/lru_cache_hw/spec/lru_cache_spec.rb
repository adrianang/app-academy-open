require 'rspec'
require 'lru_cache'

describe LRUCache do
  subject(:lru_cache) { LRUCache.new(4) }

  describe "#initalize" do
    it "initializes with an empty array" do
      expect(lru_cache.cache.is_a?(Array)).to eq(true)
    end
  end

  describe "#count" do
    it "returns the number of elements in the cache" do
      expect(lru_cache.count).to eq(0)

      lru_cache.cache = ["I walk the line", 5, [1, 2, 3]]
      expect(lru_cache.count).to eq(3)
    end
  end

  describe "#add" do
    it "adds an element to the cache according to LRU principle" do
      lru_cache.add("joaquin phoenix")
      expect(lru_cache.cache.last).to eq("joaquin phoenix")

      lru_cache.add("Hollywood Video")
      expect(lru_cache.cache[-2]).to eq("joaquin phoenix")

      lru_cache.add("joaquin phoenix")
      expect(lru_cache.cache[-2]).to eq("Hollywood Video")
      expect(lru_cache.cache.last).to eq("joaquin phoenix")
    end
  end

  describe "#show" do
    it "prints the elements in the cache, LRU item first" do
      expect(lru_cache.show).to eq([nil, nil, nil, nil])

      lru_cache.add("I walk the line")
      lru_cache.add(5)
      lru_cache.add([1, 2, 3])
      lru_cache.add(-5)
      lru_cache.add({a: 1, b: 2, c: 3})
      lru_cache.add([1, 2, 3])
      expect(lru_cache.show).to eq([5, -5, {a: 1, b: 2, c: 3}, [1, 2, 3]])
    end
  end
end