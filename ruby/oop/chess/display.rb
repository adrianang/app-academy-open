require_relative "board"
require_relative "cursor"
require "colorize"

class Display
  attr_accessor :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    rendered_board = Board.new
    # board = @board.board

    rendered_board.board.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        rendered_board[[row_idx, col_idx]] = self.board[[row_idx, col_idx]].symbol
      end
    end

    rendered_board.board.each do |row|
      puts row.join(" ")
    end
    # puts rendered_board.board
    return rendered_board
  end
end

