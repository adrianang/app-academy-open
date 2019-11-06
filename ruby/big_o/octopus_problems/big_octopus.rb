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

def measure(&block)
  start = Time.now
  block.call
  finish = Time.now
  elapsed = start - finish
  elapsed
end

p sluggish_octo(fish_array)
p "sluggish_octo(): #{ measure { sluggish_octo(fish_array) } } seconds"