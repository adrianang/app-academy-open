require_relative "board"

class Minesweeper
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    self.board.construct
    puts self.board.cheat

    until self.game_over?
      puts "Pick a position (row, column):"
      pos = self.get_input_position

      puts "Would you like to reveal ('r') or flag ('f') this position?"
      action = self.get_input_action
      if action == "r"
        self.board[pos].reveal
      else
        self.board[pos].flag
      end

      self.board.render
    end

    puts "Game over!"
  end

  def get_input_position
    user_input = gets.chomp.split(",").map(&:to_i)
    user_input
  end

  def get_input_action
    user_input = gets.chomp(&:to_lower)
    
    if !(["r", "f"]).include?(user_input[0])
      puts "Not a valid action! Type 'r' to reveal or 'f' to flag."
      self.get_input_action
    end

    user_input
  end

  def game_over?
    (0...self.board.board.length).each do |row|
      (0...self.board.board.length).each do |col|
        current_tile = self.board[[row, col]]
        if current_tile.revealed && current_tile.mined
          return true
        elsif !current_tile.revealed && !current_tile.mined
          return false
        end
      end
    end

    true
  end
end