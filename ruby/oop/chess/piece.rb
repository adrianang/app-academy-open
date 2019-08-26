module Slidable
  @@HORIZONTAL_DIRS = [:left, :up, :right, :down]
  @@DIAGONAL_DIRS = [:left_up, :right_up, :right_down, :left_up]

  def moves
    moves = []

    if self.move_dirs == self.horizontal_dirs
      (0...8).each { |col| moves << [self.pos[0], col] if (col != self.pos[1]) && self.board[[self.pos[0], col]].nil? }
      (0...8).each { |row| moves << [row, self.pos[1]] if (row != self.pos[1]) && self.board[[row, self.pos[1]]].nil? }
    elsif self.move_dirs == self.diagonal_dirs
      (1...8).each do |move_factor|
        ((self.pos[0] - move_factor)..(self.pos[1] + move_factor)).step(move_factor * 2).each do |row|
          ((self.pos[0] - move_factor)..(self.pos[1] + move_factor)).step(move_factor * 2).each do |col|
            moves << [row, col]
          end
        end
      end
    end

    moves
  end

  def horizontal_dirs
    @@HORIZONTAL_DIRS
  end

  def diagonal_dirs
    @@DIAGONAL_DIRS
  end

  def move_dirs
    if self.is_a? RookPiece
      return horizontal_dirs
    end
  end
end

module Stepable
  def moves

  end
end

class Piece
  attr_accessor :board, :pos

  def initialize(board, pos)
    @board = board
    @pos = pos
  end
end

class RookPiece < Piece
  include Slidable

  def initialize(board, pos)
    super
  end

  def move_dirs
    self.horizontal_dirs
  end
end

class BishopPiece < Piece
  include Slidable

  def initialize(board, pos)
    super
  end

  def move_dirs
    self.diagonal_dirs
  end
end