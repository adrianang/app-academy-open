require_relative "../measure"

def bad_two_sum?(arr, target_sum)
  possible_pairs = []

  arr.permutation(2).to_a.each do |poss_pair|
    return true if poss_pair.reduce(:+) == target_sum
  end

  false
end

def okay_two_sum?(arr, target_sum)
  sorted_arr = arr.sort
  max_index = -1

  sorted_arr.each_with_index do |integer, index|
    max_index = index - 1 if integer > target_sum
  end

  reduced_sorted_arr = sorted_arr[0..max_index]

  reduced_sorted_arr.each_with_index do |integer1, index1|
    reduced_sorted_arr.each_with_index do |integer2, index2|
      if index2 > index1
        return true if integer1 + integer2 == target_sum
      end
    end
  end

  false
end

def two_sum?(arr, target_sum)
  int_hash = Hash.new(0)
  arr.each { |integer| int_hash[integer] = target_sum - integer }

  int_hash.each do |key, value|
    return true if int_hash.key?(value) && (key != value)
  end

  false
end

arr = [0, 1, 5, 7]
unsorted_arr = [5, 0, 1, 7]

p bad_two_sum?(arr, 6)
p bad_two_sum?(arr, 10)

p okay_two_sum?(unsorted_arr, 6)
p okay_two_sum?(unsorted_arr, 10)

p two_sum?(arr, 6)
p two_sum?(arr, 10)

puts "bad_two_sum?: " + "%f" % measure { bad_two_sum?(arr, 10) } + " seconds"
# This method has time complexity of O(n!) because it uses permutations.

puts "okay_two_sum?: " + "%f" % measure { okay_two_sum?(unsorted_arr, 10) } + " seconds"
# This method has time complexity of O(n^2) since it uses nested loops.
# By first sorting the array, it allows the likelihood of the best case scenario to happen closer to the start of the execution by dedicating a step to defining the parameters.
# The problem is made easier since it allows the algorithm to return early, unlike using the permutation, where every possibility must first be found.

puts "two_sum?: " + "%f" % measure { two_sum?(arr, 10) } + " seconds"
# This method has linear time complexity (O(n)) since at any given time in the algorithm, it only uses a linear search/lookup method that scales linearly as the number of inputs grows.