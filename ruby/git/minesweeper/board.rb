require_relative "tile"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9) }
  end

  def seed_mines
    board_size = @board.length
    
    seeded_mines = 0
    until seeded_mines > (board_size ** 2 / 5)
      random_row_coordinate = rand(board_size)
      random_col_coordinate = rand(board_size)

      if !@board[random_row_coordinate][random_col_coordinate]
        @board[random_row_coordinate][random_col_coordinate] = Tile.new(self.board)
        @board[random_row_coordinate][random_col_coordinate].mined = true
        seeded_mines += 1
      end
    end 
  end

  def render
    rendered_board = Array.new(9) { Array.new(9) }

    (0...9).each do |row|
      (0...9).each do |col|
        if !@board[row][col]
          rendered_board[row][col] = "*"
        elsif @board[row][col].mined
          rendered_board[row][col] = "X"
        end
      end
    end

    rendered_board.each do |line|
      puts line.join(" ")
    end

    true
  end
end