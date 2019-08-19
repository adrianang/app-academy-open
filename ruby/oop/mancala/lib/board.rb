class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14) { Array.new() }
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each

    (0...@cups.length).each do |cup|
      if (cup != 6) && (cup != 13)
        @cups[cup] = [:stone, :stone, :stone, :stone]
      else
        @cups[cup] = []
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(0, @cups.length)
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)    
    starting_cup_dup = @cups[start_pos].dup
    @cups[start_pos] = []

    pos_counter = 1
    until starting_cup_dup.empty?
      if current_player_name == @player1
        if ((start_pos + pos_counter) % 14) != 13
          dropped_stone = starting_cup_dup.shift
          @cups[(start_pos + pos_counter) % 14] << dropped_stone
        end
      else
        if ((start_pos + pos_counter) % 14) != 6
          dropped_stone = starting_cup_dup.shift
          @cups[(start_pos + pos_counter) % 14] << dropped_stone
        end
      end

      pos_counter += 1
    end

    pos_counter -= 1
    self.render
    self.next_turn((start_pos + pos_counter) % 14)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if [6,13].include?(ending_cup_idx)
    return :switch if @cups[ending_cup_idx].length == 1
    return ending_cup_idx if !@cups[ending_cup_idx].empty?
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
