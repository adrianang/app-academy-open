require_relative "../measure"

def first_anagram?(word1, word2)
  possible_word1_anagrams = word1.split("").permutation.to_a
  split_word2 = word2.split("")
  
  possible_word1_anagrams.include?(split_word2)
end

def second_anagram?(word1, word2)
  word2_dupe = word2.dup.split("")

  word1.each_char do |letter|
    index = word2_dupe.find_index(letter)
    word2_dupe.delete_at(index) if index
  end

  word2_dupe.empty?
end

def third_anagram?(word1, word2)
  sorted_word1 = word1.split("").sort
  sorted_word2 = word2.split("").sort

  sorted_word1 == sorted_word2
end

def fourth_anagram?(word1, word2)
  word1_hash = Hash.new(0)
  word2_hash = Hash.new(0)

  word1.each_char { |letter| word1_hash[letter] += 1 }
  word2.each_char { |letter| word2_hash[letter] += 1 }

  word1_hash == word2_hash
end

p first_anagram?("gizmo", "sally")
p first_anagram?("elvis", "lives")

p second_anagram?("gizmo", "sally")
p second_anagram?("elvis", "lives")

p third_anagram?("gizmo", "sally")
p third_anagram?("elvis", "lives")

p fourth_anagram?("gizmo", "sally")
p fourth_anagram?("elvis", "lives")

puts "first_anagram?: " + "%f" % measure { first_anagram?("gizmo", "sally") } + " seconds"
# This solution has a time complexity of O(n!) since it uses a permutation.
# If the string size is increased, it would take very long since it follows permutative growth.

puts "second_anagram?: " + "%f" % measure { second_anagram?("gizmo", "sally") } + " seconds"
# This solution has a time complexity of O(n^2) since it uses find_index, a method that traverses through the array to return an index, within a loop.
# This is different from first_anagram in that it will go through n^2 options, as opposed to n! options (for a string length 5, 25 v. 120 options)

puts "third_anagram?: " + "%f" % measure { third_anagram?("gizmo", "sally") } + " seconds"
# This solution has a time complexity of O(n log n) since it uses the built-in sort method, which is based off of Quicksort.
# This solution has a better time complexity than second_anagram.

puts "fourth_anagram?: " + "%f" % measure { fourth_anagram?("gizmo", "sally") } + " seconds"
# This solution has a time complexity of O(n) since it only uses hash search and insertion functions (O(1)) inside a loop.
