require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
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
    @map.include?(key) ? self.update_node!(@map[key]) : self.calc!(key)
    self.eject! if self.count > @max
    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  # private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map.set(key, @store.last)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.append(node.key, node.val)
    @store.remove(node.key)
    @map.set(node.key, @store.last)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end