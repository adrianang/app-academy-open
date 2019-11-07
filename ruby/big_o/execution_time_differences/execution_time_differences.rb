int_list = [0, 3, 5, 4, -5, 10, 1, 90]

def my_min1(list)
  list.each do |main_int|
    found_smallest = false
    
    list.each do |int_to_compare|
      break if int_to_compare < main_int
      found_smallest if int_to_compare == list.last
    end
    
    return main_int if found_smallest
  end

  nil
end

p my_min1(int_list)