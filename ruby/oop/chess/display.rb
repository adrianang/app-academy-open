require_relative "board"
require_relative "cursor"
require "colorize"

class Display
  attr_accessor :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    # rendered_board = Board.new
    # # board = @board.board

    # rendered_board.board.each_with_index do |row, row_idx|
    #   row.each_with_index do |col, col_idx|
    #     rendered_board[[row_idx, col_idx]] = self.board[[row_idx, col_idx]].symbol
    #   end
    # end

    # rendered_board.board.each do |row|
    #   puts row.join(" ")
    # end
    # # puts rendered_board.board
    # return rendered_board


    # @board.board.map.with_index do |row, i|
    #   row.map.with_index do |piece, j|
    #     puts piece.symbol.colorize(piece.color).colorize( :background => :red)
    #   end
    # end

    rendered_board = Board.new
    
    rendered_board.board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if [i, j] == @cursor.cursor_pos
          bg = :red
        else
          bg = :green
        end

        rendered_board[[i, j]] = self.board[[i, j]].symbol.colorize(:color => self.board[[i, j]].color, :background => bg)
      end
    end
  
    rendered_board.board.each do |row|
      puts row.join(" ")
    end
  end
end

