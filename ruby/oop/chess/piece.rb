module Slidable
  @@HORIZONTAL_DIRS = [[0, -1], [-1, 0], [0, 1], [1, 0]]
  @@DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, 1], [1, -1]]

  def moves
    moves = []

    self.move_dirs.each do |direction|
      new_left_coord = self.pos[0] + direction[0]
      new_right_coord = self.pos[1] + direction[1]
      new_possible_pos = [new_left_coord, new_right_coord]

      while new_possible_pos.all? { |coord| (0..7).include?(coord) }
        if self.board[new_possible_pos].is_a?(NullPiece)
          moves << new_possible_pos
        elsif self.board[new_possible_pos].color != self.color
          moves << new_possible_pos
          break
        else
          break
        end

        new_possible_pos = [new_possible_pos[0] + direction[0], new_possible_pos[1] + direction[1]]
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
    return self.forward_steps if self.is_a?(PawnPiece)
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

    self.moves.select { |pos| (0..7).include?(pos[0]) && (0..7).include?(pos[1]) }
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
  attr_accessor :color, :board, :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def valid_moves
  end

  def symbol
    self.symbol
  end

  def move_into_check?(end_pos)
    board_dup = Marshal.load(Marshal.dump(@board))

    # make move on duped board
    # check if the player/color is in check
      # if in check, return true
      # else, return false
  end
end

class RookPiece < Piece
  include Slidable

  def initialize(color, board, pos)
    super
  end

  def symbol
    return ' ♜ ' if self.color == :black
    return ' ♖ ' if self.color == :white
  end

  def move_dirs
    self.horizontal_dirs
  end
end

class BishopPiece < Piece
  include Slidable

  def initialize(color, board, pos)
    super
  end

  def symbol
    return " ♝ " if self.color == :black
    return " ♗ " if self.color == :white
  end

  def move_dirs
    self.diagonal_dirs
  end
end

class QueenPiece < Piece
  include Slidable

  def initialize(color, board, pos)
    super
  end

  def symbol
    return " ♛ " if self.color == :black
    return " ♕ " if self.color == :white
  end

  def move_dirs
    self.horizontal_dirs + self.diagonal_dirs
  end
end

class KnightPiece < Piece
  include Stepable

  def initialize(color, board, pos)
    super
  end

  def symbol
    return " ♞ " if self.color == :black
    return " ♘ " if self.color == :white
  end

  def move_diffs
    @@L_SHAPE
  end
end

class KingPiece < Piece
  include Stepable

  def initialize(color, board, pos)
    super
  end

  def symbol
    return " ♚ " if self.color == :black
    return " ♔ " if self.color == :white
  end

  def move_diffs
    @@RING
  end
end

class NullPiece < Piece
  def initialize
  end

  def symbol
    return "   "
  end

  def moves
    nil
  end
end

class PawnPiece < Piece
  def initialize(color, board, pos)
    super
  end

  def symbol
    return " ♟ ️" if self.color == :black
    return " ♙ " if self.color == :white
  end

  def move_dirs
    [:forward, :side]
  end

  def at_start_row?
    return false if (self.pos[0] != 1) && (self.pos[0] != 6)
    true
  end

  def forward_dir
    if self.color == :black
      return 1
    else
      return -1
    end
  end

  def moves
    moves = []
    if self.at_start_row?
      moves << [self.pos[0] + (self.forward_dir * 2), self.pos[1]] 
    end
    moves << [self.pos[0] + self.forward_dir, self.pos[1]]
    moves
  end

  def side_attacks
  end
end