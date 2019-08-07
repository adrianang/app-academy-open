require_relative "tile"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9) }
  end

  def [](pos)
    row, col = pos
    @board[row - 1][col - 1]
  end

  def []=(pos, value)
    row, col = pos
    @board[row - 1][col - 1] = value
  end

  def seed_mines
    board_size = @board.length
    
    seeded_mines = 0
    until seeded_mines > (board_size ** 2 / 5)
      random_row_coordinate = rand(board_size)
      random_col_coordinate = rand(board_size)
      pos = [random_row_coordinate, random_col_coordinate]

      if !self[pos]
        self[pos] = Tile.new(self.board)
        self[pos].mined = true
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

    puts "  #{(1..9).to_a.join(" ")}"
    rendered_board.each_with_index do |line, index|
      puts "#{index + 1} #{line.join(" ")}"
    end

    true
  end
end