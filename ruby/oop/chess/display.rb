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
    system("clear")
    rendered_board = Board.new
    
    rendered_board.board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if [i, j] == @cursor.cursor_pos
          if @cursor.selected
            bg = :green
          else
            bg = :red
          end
        elsif (i + j).odd?
          bg = :blue
        else
          bg = :light_blue
        end

        rendered_board[[i, j]] = self.board[[i, j]].symbol.colorize(:color => self.board[[i, j]].color, :background => bg)
      end
    end
  
    rendered_board.board.each do |row|
      puts row.join("")
    end
  end

  def make_move
    flag = true
    until !flag
      self.render
      @cursor.get_input
    end
  end
end

