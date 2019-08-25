require_relative "piece"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
    # self.initialize_pieces
  end

  def initialize_pieces
    @board[0] = @board[0].map { |space| space = Piece.new(self, nil) }
    @board[1] = @board[1].map { |space| space = Piece.new(self, nil) }
    @board[-2] = @board[-2].map { |space| space = Piece.new(self, nil) }
    @board[-1] = @board[-1].map { |space| space = Piece.new(self, nil) }
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
    raise PositionError.new "There is no piece at #{start_pos}." if self[start_pos].nil?
    raise PositionError.new "The piece cannot move to #{end_pos}." if !self[end_pos].nil?

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    true
  end
end

class PositionError < StandardError
end