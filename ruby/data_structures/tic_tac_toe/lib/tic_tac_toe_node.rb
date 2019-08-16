require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.board.over?
      return true if self.board.winner != evaluator
      return false if (self.board.winner == evaluator) || self.board.winner.nil?
    end

    if evaluator == self.next_mover_mark
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    possible_moves = []

    (0...3).each do |row|
      (0...3).each do |col|
        if self.board.empty?([row, col])
          new_move = TicTacToeNode.new(self.board.dup, ((self.next_mover_mark == :x) ? :o : :x), [row, col])
          new_move.board[[row, col]] = @next_mover_mark
          possible_moves << new_move
        end
      end
    end

    possible_moves
  end
end
