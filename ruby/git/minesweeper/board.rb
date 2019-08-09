require_relative "tile"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9) { Tile.new(self.board) } }
  end

  def [](pos)
    row, col = pos
    @board[row - 1][col - 1]
  end

  def []=(pos, value)
    row, col = pos
    @board[row - 1][col - 1] = value
  end

  def assign_coordinates
    (0...@board.length).each do |row|
      (0...@board.length).each do |col|
        @board[row][col].position_on_board = [row, col] 
      end
    end
  end

  def seed_mines
    board_size = @board.length
    
    seeded_mines = 0
    until seeded_mines > (board_size ** 2 / 5)
      random_row_coordinate = rand(board_size)
      random_col_coordinate = rand(board_size)
      pos = [random_row_coordinate, random_col_coordinate]

      if !self[pos].mined
        self[pos].mined = true
        self[pos].position_on_board = pos.map { |index| index - 1 }
        seeded_mines += 1
      end
    end 
  end

  def pass_board_to_tile
    (0...@board.length).each do |row|
      (0...@board.length).each do |col|
        @board[row][col].board = @board
      end
    end    
  end

  def construct
    self.assign_coordinates
    self.seed_mines
    self.pass_board_to_tile
    true
  end

  def render
    rendered_board = Array.new(9) { Array.new(9) }

    (0...9).each do |row|
      (0...9).each do |col|
        if !@board[row][col].mined
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