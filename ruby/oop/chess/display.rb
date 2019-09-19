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

  # testing in pry
  def make_move
    flag = true
    until !flag
      self.render
      @cursor.get_input
    end
  end

  def move_into_checkmate
    self.board.move_piece([6, 5], [5, 5])
    self.board.move_piece([1, 4], [3, 4])
    self.board.move_piece([6, 6], [4, 6])
    self.board.move_piece([0, 3], [4, 7])
  end

  def testing_piece_moves
    # Bishop Testing
    # self.board[[3,3]] = BishopPiece.new(:black, self.board, [3, 3])
    # self.board[[1,1]] = PawnPiece.new(:white, self.board, [1, 1])
    # self.board[[6,6]] = PawnPiece.new(:black, self.board, [6, 6])
    # self.board[[2,4]] = PawnPiece.new(:black, self.board, [2, 4])
    # self.board[[6,3]] = PawnPiece.new(:white, self.board, [6, 3])
    # return self.board[[3,3]].moves

    # Rook Testing
    # self.board[[5,1]] = RookPiece.new(:black, self.board, [5,1]) 
    # self.board[[5,7]] = PawnPiece.new(:black, self.board, [5,7])
    # return self.board[[5,1]].moves

    # Queen Testing
    self.board.initialize_pieces
    self.move_into_checkmate
    # return self.board[[4,7]].moves

    # Knight Testing
    # self.board[[4, 4]] = KnightPiece.new(:black, self.board, [4,4])
    # self.board[[6, 5]] = PawnPiece.new(:black, self.board, [6,5])
    # self.board[[3, 6]] = PawnPiece.new(:white, self.board, [3,6])
    # return self.board[[4,4]].moves

    # self.board[[6, 2]] = KnightPiece.new(:black, self.board, [6,2])
    # return self.board[[6,2]].moves

    # King Testing
    # self.board[[4, 4]] = KingPiece.new(:black, self.board, [4,4])
    # return self.board[[4,4]].moves

    # self.board[[7, 0]] = KingPiece.new(:black, self.board, [7,0])
    # return self.board[[7,0]].moves
  end
end

