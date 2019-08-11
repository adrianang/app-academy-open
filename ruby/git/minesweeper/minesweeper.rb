require_relative "board"

class Minesweeper
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def inspect
    { 'board' => 'initialized' }
  end

  def play
    self.board.construct
    puts self.board.cheat
    self.play_turn until self.game_over?
    self.format_board_rendering
    puts "Game over!"
  end

  def play_turn
    self.format_board_rendering
    pos = self.get_input_position
    action = self.get_input_action
    self.run_action(action, pos)
    system "clear"
  end

  def get_input_position
    puts "Pick a position (row, column):"
    user_input = gets.chomp.split(",").map(&:to_i)
    user_input
  end

  def get_input_action
    puts "Would you like to reveal ('r') or (un)flag ('f') this position?"
    user_input = gets.chomp(&:to_lower)
    
    if !(["r", "f"]).include?(user_input[0])
      puts "Not a valid action! Type 'r' to reveal or 'f' to flag."
      self.get_input_action
    end

    user_input
  end

  def run_action(action, pos)
    if action == "r"
      if !self.board[pos].flagged
        self.board[pos].reveal
      else
        puts "You must unflag a tile if you'd like to reveal it; try again."
        new_pos = self.get_input_position
        new_action = self.get_input_action
        self.run_action(new_action, new_pos)
      end
    else
      if !self.board[pos].revealed
        self.board[pos].flag
      else
        puts "You've already revealed this tile; try again."
        new_pos = self.get_input_action
        new_action = self.get_input_action
        self.run_action(new_action, new_pos)
      end
    end
  end

  def format_board_rendering
    puts "======================"
    self.board.render
    puts "======================"
  end

  def game_over?
    return true if self.mine_revealed?
    
    if self.all_tiles_revealed?
      puts "You mined the entire board safely! :)"
      return true
    else
      return false
    end
  end

  def mine_revealed?
    (0...self.board.board.length).each do |row|
      (0...self.board.board.length).each do |col|
        current_tile = self.board[[row, col]]

        if current_tile.revealed && current_tile.mined
          puts "You lost by hitting a mine :("
          return true
        end
      end
    end

    false
  end

  def all_tiles_revealed?
    (0...self.board.board.length).each do |row|
      (0...self.board.board.length).each do |col|
        current_tile = self.board[[row, col]]

        if !current_tile.revealed && !current_tile.mined
          return false
        end
      end
    end

    true
  end
end