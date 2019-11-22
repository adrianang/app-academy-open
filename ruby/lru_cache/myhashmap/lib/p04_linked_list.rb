class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove_self
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    (@head.next == @tail) && (@tail.prev == @head) ? true : false
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    self.each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    node_to_append = Node.new(key, val)
    node_to_append.next = @tail
    node_to_append.prev = @tail.prev
    @tail.prev.next = node_to_append
    @tail.prev = node_to_append
  end

  def update(key, val)
    self.each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.remove_self
        break
      end
    end
  end

  def each
    node_in_list = self.first
    
    until !node_in_list.next
      yield node_in_list
      node_in_list = node_in_list.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
