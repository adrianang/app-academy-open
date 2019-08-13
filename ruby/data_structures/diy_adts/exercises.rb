# Exercise 1, Stack
class Stack
  def initialize
    @stack = []
  end

  def push(el)
    @stack.push(el)
  end
  
  def pop
    @stack.pop
  end

  def peek
    @stack[-1]
  end
end

#Exercise 2, Queue
class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue[0]
  end
end

#Exercise 3, Map
class Map
  attr_accessor :map

  def initialize
    @map = []
  end

  def set(key, value)
    keys = @map.map { |pair| pair[0] }

    if !keys.include?(key)
      @map << [key, value]
    elsif keys.include?(key)
      key_index = keys.index(key)
      @map[key_index][1] = value
    end

    @map
  end

  def get(key)
    @map.each do |pair|
      return pair if pair[0] == key
    end

    return nil
  end

  def delete(key)
    pair_index = nil

    @map.each do |pair|
      pair_index = @map.index(pair) if pair[0] == key
    end

    if pair_index
      @map.delete_at(pair_index)
      return @map
    else
      return nil
    end
  end

  def show
    @map.each do |pair|
      puts "#{pair[0]} => #{pair[1]}"
    end

    true
  end
end