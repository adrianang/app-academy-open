int_list = [0, 3, 5, 4, -5, 10, 1, 90]

def my_min1(list)
  list.each do |main_int|
    found_smallest = false
    
    list.each do |int_to_compare|
      break if int_to_compare < main_int
      found_smallest = true if int_to_compare == list.last
    end

    return main_int if found_smallest
  end

  nil
end

def my_min2(list)
  smallest = list.first
  list.each { |integer| smallest = integer if integer < smallest }
  smallest
end

def measure(&block)
  start = Time.now
  block.call
  finish = Time.now
  elapsed = finish - start
  elapsed
end

p my_min1(int_list) ## The time complexity for this function is O(n^2).
p my_min2(int_list) ## The time complexity for this funciton is O(n).

p "my_min1: " + "%f" % measure { my_min1(int_list) } + " seconds"
p "my_min1: " + "%f" % measure { my_min2(int_list) } + " seconds"
