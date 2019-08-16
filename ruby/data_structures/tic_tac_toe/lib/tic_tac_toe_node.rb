require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    possible_moves = []

    (0...3).each do |row|
      (0...3).each do |col|
        if self.board[[row, col]].nil?
          possible_moves << TicTacToeNode.new(self.board.dup, ((self.next_mover_mark == :x) ? :o : :x), [row, col])
        end
      end
    end

    possible_moves
  end
end
