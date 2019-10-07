class Array
  def two_sum
    self.each { |ele| raise ArgumentError.new if !ele.is_a?(Integer) }
    sums = []

    self.each_with_index do |ele, i|
      self.each_with_index do |ele_for_ele, j|
        if (ele + ele_for_ele == 0) && (i < j)
          sums << [i, j]
        end
      end
    end

    sums
  end
end