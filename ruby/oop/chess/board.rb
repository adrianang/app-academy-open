require_relative "piece"

class Board
  attr_accessor :board, :error_msg

  def initialize
    @board = Array.new(8) { Array.new(8) { NullPiece.new } }
    @error_msg = nil
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
        self[[row, 3]] = QueenPiece.new(:white, self, [row, 3])
        self[[row, 4]] = KingPiece.new(:white, self, [row, 4])
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
    begin
      if self[start_pos].move_into_check?(end_pos)
        raise InCheckError.new
      elsif self[start_pos].is_a?(NullPiece) || !self[start_pos].valid_moves.include?(end_pos)
        raise PositionError.new
      elsif self[start_pos].valid_moves.include?(end_pos)
        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.new

        self[end_pos].pos = end_pos
      end
    rescue PositionError => e
      self.error_msg = "There is no piece at #{start_pos}." if self[start_pos].is_a?(NullPiece)
      self.error_msg = "This piece type cannot move to #{end_pos}." if !self[start_pos].valid_moves.include?(end_pos)
    rescue InCheckError => e
      self.error_msg = "Making this move would leave you in check (and losing)."
    end
  end

  def checkmate?(color)
    if self.in_check?(color)
      self.board.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          if (piece.color == color) && !piece.valid_moves.empty?
            return false
          end
        end
      end

      return true
    end

    return false
  end

  def in_check?(color)
    @board.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.color != color && !piece.is_a?(NullPiece)
          return true if piece.moves.include?(self.find_king(color))
        end
      end
    end

    return false
  end

  def find_king(color)
    @board.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        return [i, j] if (piece.is_a?(KingPiece)) && (piece.color == color)
      end
    end
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
    self[end_pos].pos = end_pos
    true
  end
end

class PositionError < StandardError
end

class InCheckError < StandardError
end