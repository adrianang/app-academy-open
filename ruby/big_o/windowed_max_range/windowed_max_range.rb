require_relative "../measure"

# Phase 1: Naive Solution
def windowed_max_range(array, window_size)
  current_max_range = nil

  array.each_with_index do |ele, idx|
    window = array[idx..idx + window_size - 1]

    if window.length == window_size
      window_min = window.min
      window_max = window.max
      window_max_range = window_max - window_min
      current_max_range = window_max_range if !current_max_range || (window_max_range > current_max_range)
    end
  end

  current_max_range
end

arr = [1, 2, 3, 5]
arr2 = [1, 0, 2, 5, 4, 8]
arr3 = [1, 3, 2, 5, 4, 8]

puts windowed_max_range(arr, 3)
puts windowed_max_range(arr2, 2)
puts windowed_max_range(arr2, 3)
puts windowed_max_range(arr2, 4)
puts windowed_max_range(arr3, 5)

p "windowed_max_range: " + "%f" % measure { windowed_max_range(arr, 3) } + " seconds"
# The overall time complexity for this solution is O(n^2). It uses min and max methods (each O(n)) within a loop over an array (also O(n)),


# Phase 2: MyQueue
class MyQueue
  def initialize
    @store = []
  end

  def enqueue(ele)
    @store.push(ele)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end


# Phase 3: MyStack
class MyStack
  def initialize
    @store = []
  end

  def push(ele)
    @store.push(ele)
  end

  def pop
    @store.pop
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end


# Phase 4: StackQueue
class StackQueue
  def initialize
    @push_in_stack = MyStack.new
    @pop_out_stack = MyStack.new
  end

  def enqueue(ele)
    @push_in_stack.push(ele)
  end

  def dequeue
    if @pop_out_stack.empty?
      @pop_out_stack.push(@push_in_stack.pop) until @push_in_stack.empty?
    end

    @pop_out_stack.pop
  end

  def size
    @push_in_stack.size + @pop_out_stack.size
  end

  def empty?
    @push_in_stack.empty? && @pop_out_stack.empty?
  end
end


# Phase 5: MinMaxStack
class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def push(ele)
    metadata = {
      val: ele,
      max: self.empty? ? ele : [self.max, ele].max,
      min: self.empty? ? ele : [self.min, ele].min
    }

    @store.push(metadata)
  end

  def pop
    @store.pop
  end

  def max
    @store.peek[:max] unless self.empty?
  end

  def min
    @store.peek[:min] unless self.empty?
  end

  def peek
    @store.peek[:val] unless self.empty?
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end


# Phase 6: MinMaxStackQueue
class MinMaxStackQueue
  def initialize
    @push_in_stack = MinMaxStack.new
    @pop_out_stack = MinMaxStack.new
  end

  def enqueue(ele)
    @push_in_stack.push(ele)
  end

  def dequeue
    if @pop_out_stack.empty?
      @pop_out_stack.push(@push_in_stack.pop[:val]) until @push_in_stack.empty?
    end

    @pop_out_stack.pop
  end

  def max
    poss_maxes = []
    poss_maxes << @push_in_stack.max if @push_in_stack.max
    poss_maxes << @pop_out_stack.max if @pop_out_stack.max
    poss_maxes.max
  end

  def min
    poss_mins = []
    poss_mins << @push_in_stack.min if @push_in_stack.min
    poss_mins << @pop_out_stack.min if @pop_out_stack.min
    poss_mins.min
  end

  def size
    @push_in_stack.size + @pop_out_stack.size
  end

  def empty?
    @push_in_stack.empty? && @pop_out_stack.empty?
  end
end