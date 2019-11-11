int_list = [0, 3, 5, 4, -5, 10, 1, 90]
subsum_ints = [5, 3, -7]
subsum_ints2 = [2, 3, -6, 7, -6, 7]
subsum_ints3 = [-5, -1, -3]

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

def largest_contiguous_subsum1(list)
  all_subarrs = []

  list.each_with_index do |int1, idx1|
    list.each_with_index do |int2, idx2|
      all_subarrs << list[idx1..idx2] if !list[idx1..idx2].empty?
    end
  end

  subarr_sums = all_subarrs.map { |subarr| subarr.reduce(:+) }
  subarr_sums.max  
end

def largest_contiguous_subsum2(list)
  current_largest_subsum = list.first
  accumulator = 0

  list.each do |num|
    accumulator = 0 if accumulator < 0
    accumulator += num

    if accumulator > current_largest_subsum
      current_largest_subsum = accumulator
    end
  end

  current_largest_subsum
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

p largest_contiguous_subsum1(subsum_ints) ## The time complexity for this function is O(n^2).
p largest_contiguous_subsum2(subsum_ints) ## The time complexity for this function is O(n) because it uses one loop that runs linearly depending on the number of inputs. It has O(1) memory because although it uses two memory spaces (current_largest_subsum and accumulator), that simplifies to a constant space notation when scaled over a long period of time.
p largest_contiguous_subsum2(subsum_ints2)
p largest_contiguous_subsum2(subsum_ints3)

p "largest_contiguous_subsum1: " + "%f" % measure { largest_contiguous_subsum1(subsum_ints) } + " seconds"
p "largest_contiguous_subsum2: " + "%f" % measure { largest_contiguous_subsum2(subsum_ints) } + " seconds"