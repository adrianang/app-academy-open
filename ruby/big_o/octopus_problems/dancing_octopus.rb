tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(direction, tiles)
  tiles.each_with_index do |arrow, index|
    return index if direction == arrow
  end
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
