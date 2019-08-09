require_relative "tile"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9) { Tile.new(self.board) } }
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
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
        seeded_mines += 1
      end
    end 
  end

  def assign_neighbors
    (0...@board.length).each do |row|
      (0...@board.length).each do |col|
        self[[row, col]].find_neighbors
      end
    end    
  end

  def construct
    self.assign_coordinates
    self.seed_mines
    self.assign_neighbors
    self.update_board
    true
  end

  def update_board
    (0...9).each do |row|
      (0...9).each do |col|
        self[[row, col]].board = @board
      end
    end
  end

  def render
    rendered_board = Array.new(9) { Array.new(9) }

    (0...9).each do |row|
      (0...9).each do |col|
        if !@board[row][col].mined #&& ((1..8).include?(row)) && ((1..8).include?(col))
          rendered_board[row][col] = self[[row, col]].neighbor_mine_count
        elsif @board[row][col].mined
          rendered_board[row][col] = "X"
        end
      end
    end

    puts "  #{(0...9).to_a.join(" ")}"
    rendered_board.each_with_index do |line, index|
      puts "#{index} #{line.join(" ")}"
    end

    true
  end
end