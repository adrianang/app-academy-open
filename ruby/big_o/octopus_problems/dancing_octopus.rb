tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left", "left-up"]
tiles_hash = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7
}

def slow_dance(direction, tiles)
  tiles.each_with_index do |arrow, index|
    return index if direction == arrow
  end
end

def fast_dance(direction, tiles)
  tiles[direction]
end

def measure(&block)
  start = Time.now
  block.call
  finish = Time.now
  elapsed = start - finish
  elapsed
end

p slow_dance("up", tiles_array)
p slow_dance("right-down", tiles_array)

p fast_dance("up", tiles_hash)
p fast_dance("right-down", tiles_hash)

# Best case
p "slow_dance(): #{ measure { slow_dance("up", tiles_array) } }"
p "fast_dance(): #{ measure { fast_dance("up", tiles_hash) } }"

# Other case
p "slow_dance(): #{ measure { slow_dance("right-down", tiles_array) } }"
p "fast_dance(): #{ measure { fast_dance("right-down", tiles_hash) } }"