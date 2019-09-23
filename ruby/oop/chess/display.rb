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

    puts "Current selected piece: #{ @cursor.selected_piece_pos }"
    puts "Current cursor position: #{ @cursor.cursor_pos }"

    if @cursor.selected_piece_pos && !@cursor.selected_piece_pos.empty?
      puts "Valid moves: #{ self.board[@cursor.selected_piece_pos].valid_moves }"
    end

    if self.board.error_msg
      puts self.board.error_msg
    end
  end
end

