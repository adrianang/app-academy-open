require_relative "board"
require_relative "display"
require_relative "player"

class Game
  attr_accessor :board, :display, :player_1, :player_2

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_1 = HumanPlayer.new(:white, @display)
    @player_2 = HumanPlayer.new(:black, @display)
    @current_player = @player_1
  end

  def play
    until self.board.checkmate?(@player_1.color) || self.board.checkmate?(@player_2.color)
      @current_player.make_move(self.board)
      @current_player = self.player_1 ? @current_player = self.player_2 : @current_player = self.player_1
    end

    self.board.checkmate?(@player_1.color) ? winner = "Player 1 (White)" : winner = "Player 2 (Black)"
    puts "The game is over; #{winner} wins the match."
  end
end