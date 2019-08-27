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
    else
      (1...8).each do |move_factor|
        ((self.pos[0] - move_factor)..(self.pos[1] + move_factor)).step(move_factor).each do |row|
          ((self.pos[0] - move_factor)..(self.pos[1] + move_factor)).step(move_factor).each do |col|
            moves << [row, col] if ([row, col] != self.pos)
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
    self.move_dirs
  end
end

module Stepable
  @@L_SHAPE = [:two, :one]
  @@RING = [:one]

  def moves
    moves = []

    if self.move_diffs == self.l_shape
      ((self.pos[0] - 1)..(self.pos[0] + 1)).step(2).each do |row|
        ((self.pos[1] - 2)..(self.pos[1] + 2)).step(4).each do |col|
          moves << [row, col]
        end
      end

      ((self.pos[0] - 2)..(self.pos[0] + 2)).step(4).each do |row|
        ((self.pos[1] - 1)..(self.pos[1] + 1)).step(2).each do |col|
          moves << [row, col]
        end
      end
    else self.move_diffs == self.ring
      ((self.pos[0] - 1)..(self.pos[0] + 1)).each do |row|
        ((self.pos[1] - 1)..(self.pos[1] + 1)).each do |col|
          moves << [row, col] if [row, col] != self.pos
        end
      end
    end

    moves
  end

  def move_diffs
    self.move_diffs
  end

  def l_shape
    @@L_SHAPE
  end

  def ring
    @@RING
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

class QueenPiece < Piece
  include Slidable

  def initialize(board, pos)
    super
  end

  def move_dirs
    self.horizontal_dirs + self.diagonal_dirs
  end
end

class KnightPiece < Piece
  include Stepable

  def move_diffs
    @@L_SHAPE
  end
end

class KingPiece < Piece
  include Stepable

  def move_diffs
    @@RING
  end
end