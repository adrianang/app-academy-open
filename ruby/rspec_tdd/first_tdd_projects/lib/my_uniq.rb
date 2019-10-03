def my_uniq(array)
  raise ArgumentError.new if !array.is_a?(Array)
  new_uniq_array = []

  array.each do |ele|
    new_uniq_array << ele if !new_uniq_array.include?(ele)
  end

  new_uniq_array
end