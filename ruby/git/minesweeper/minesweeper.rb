require_relative "board"

class Minesweeper
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    self.board.construct
    puts "Pick a position (row, column):"
    self.get_input
  end

  def get_input
    user_input = gets.chomp.split(",").map(&:to_i)
    user_input
  end
end