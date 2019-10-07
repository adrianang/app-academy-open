def my_transpose(array)
  raise ArgumentError.new if !array.is_a?(Array)
  array.each do |row|
    raise ArgumentError.new("Not a square matrix") if row.length != array.length
    row.each { |ele| raise ArgumentError.new("The matrix is not comprised of integers") if !ele.is_a?(Integer) } 
  end

  transposed_array = Array.new(array[0].length) { Array.new(array[0].length) }

  array.each_with_index do |row, i|
    row.each_with_index do |ele, j|
      transposed_array[i][j] = array[j][i]
    end
  end

  transposed_array
end