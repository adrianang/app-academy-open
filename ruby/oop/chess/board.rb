require_relative "piece"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
    self.initialize_pieces
  end

  def initialize_pieces
    (1..6).each do |row|
      if row == 1
        (0..7).each { |col| self[[row, col]] = PawnPiece.new(:black, self, [row, col]) }
      elsif row == 6
        (0..7).each { |col| self[[row, col]] = PawnPiece.new(:white, self, [row, col]) }
      else
        (0..7).each { |col| self[[row, col]] = NullPiece.new }
      end
    end

    (0..7).step(7).each do |row|
      (0..7).step(7).each do |col|
        self[[row, col]] = RookPiece.new(:black, self, [row, col]) if row == 0
        self[[row, col]] = RookPiece.new(:white, self, [row, col]) if row == 7
      end

      (1..6).step(5).each do |col|
        self[[row, col]] = KnightPiece.new(:black, self, [row, col]) if row == 0
        self[[row, col]] = KnightPiece.new(:white, self, [row, col]) if row == 7 
      end

      (2..5).step(3).each do |col|
        self[[row, col]] = BishopPiece.new(:black, self, [row, col]) if row == 0
        self[[row, col]] = BishopPiece.new(:white, self, [row, col]) if row == 7
      end

      if row == 0
        self[[row, 3]] = QueenPiece.new(:black, self, [row, 3])
        self[[row, 4]] = KingPiece.new(:black, self, [row, 4])
      elsif row == 7
        self[[row, 3]] = KingPiece.new(:white, self, [row, 3])
        self[[row, 4]] = QueenPiece.new(:white, self, [row, 4])
      end
    end
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
  end 

  def move_piece(start_pos, end_pos)
    raise PositionError.new "There is no piece at #{start_pos}." if self[start_pos].is_a?(NullPiece)
    raise PositionError.new "The piece cannot move to #{end_pos}." if !self[end_pos].is_a?(NullPiece)
    raise PositionError.new "This piece type cannot move to #{end_pos}" if !self[start_pos].valid_moves.include?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new

    self[end_pos].pos = end_pos
    true
  end
end

class PositionError < StandardError
end