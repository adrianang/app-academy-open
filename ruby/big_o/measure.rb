def measure(&block)
  start = Time.now
  block.call
  finish = Time.now
  elapsed = finish - start
  elapsed
end