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
    until self.game_over?
      system("clear")
      self.notify_players
      self.display.render
      move = @current_player.make_move(self.board)

      if move == self.display.cursor.cursor_pos && !self.display.cursor.selected
        self.swap_turn!
      end
    end

    system("clear")
    puts "Game over - checkmate!"
    self.display.render
    self.board.checkmate?(@player_1.color) ? winner = "Player 1 (White)" : winner = "Player 2 (Black)"
    puts "The game is over; #{ winner } wins the match."
  end

  def notify_players
    @current_player == @player_1 ? name = "Player 1 / White" : name = "Player 2 / Black"
    puts "Current player: #{ name }"
  end

  def swap_turn!
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def game_over?
    if self.board.checkmate?(@player_1.color) || self.board.checkmate?(@player_2)
      return true
    else
      return false
    end
  end
end