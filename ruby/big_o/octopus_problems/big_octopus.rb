fish_array = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish_octo(fishes)
  longest_fish = fishes.first

  fishes.each do |main_fish|
    fishes.each do |fish_to_compare|
      longest_fish = fish_to_compare if main_fish.length < fish_to_compare.length
    end
  end

  longest_fish
end

def dominant_octopus(fishes)
  merge_sort(fishes).last
end

def merge_sort(array)
  return array if array.length <= 1
  
  middle = array.length / 2
  left_subarr = merge_sort(array[0...middle])
  right_subarr = merge_sort(array[middle..-1])

  merge(left_subarr, right_subarr)
end

def merge(left_arr, right_arr)
  sorted = []

  until left_arr.empty? || right_arr.empty?
    if left_arr[0].length > right_arr[0].length
      sorted << right_arr.shift
    elsif right_arr[0].length > left_arr[0].length
      sorted << left_arr.shift
    elsif left_arr[0].length == right_arr[0].length
      sorted << left_arr.shift
      sorted << right_arr.shift
    end
  end

  sorted + left_arr + right_arr
end

def measure(&block)
  start = Time.now
  block.call
  finish = Time.now
  elapsed = start - finish
  elapsed
end

p sluggish_octo(fish_array)
p "sluggish_octo(): #{ measure { sluggish_octo(fish_array) } } seconds"

p dominant_octopus(fish_array)
p "dominant_octo(): #{ measure { dominant_octopus(fish_array) } } seconds"