def stock_picker(array)
  raise TypeError.new("A non-array was passed into the method") if !array.is_a?(Array)
  array.each { |ele| raise ArgumentError.new("Not all elements are stock prices") if !ele.is_a?(Numeric) }
  return array if array.empty?

  profitable_dates = []

  current_profit_margin = 0
  array.each_with_index do |buy_price, i|
    array.each_with_index do |sell_price, j|
      if j > i
        profit_margin_option = sell_price - buy_price

        if profit_margin_option == current_profit_margin
          profitable_dates << [i, j]
        elsif profit_margin_option > current_profit_margin
          profitable_dates = []
          profitable_dates << [i, j]
          current_profit_margin = profit_margin_option 
        end
      end
    end  
  end

  profitable_dates.length > 1 ? profitable_dates : profitable_dates.first
end