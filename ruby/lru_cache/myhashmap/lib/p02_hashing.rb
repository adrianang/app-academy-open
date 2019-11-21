class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash_to_hash = 0

    self.each_with_index do |ele, idx|
      hash_to_hash += (ele.hash + idx).hash
    end

    hash_to_hash.hash
  end
end

class String
  def hash
    hash_to_hash = 0

    self.each_char.with_index do |char, idx|
      hash_to_hash += (char.ord.hash + idx).hash
    end
    
    hash_to_hash.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_to_hash = 0
    arrayed_hash = []

    self.each { |key, val| arrayed_hash << [key.to_s.ord, val] }
    arrayed_hash.sort
    arrayed_hash.each { |ele| hash_to_hash += ele.hash }

    hash_to_hash.hash
  end
end
