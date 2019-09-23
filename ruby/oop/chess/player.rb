require_relative "display"

class Player
  attr_accessor :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end
end

class HumanPlayer < Player
  def initialize(color, display)
    super
  end

  def make_move(board)
    begin
      player_input = self.display.cursor.get_input

      if player_input == self.display.cursor.cursor_pos
        if self.display.board[player_input].color != self.color
          self.display.cursor.toggle_selected
          raise WrongColorError.new
        end
      end

      player_input
    rescue WrongColorError => e
      puts "Piece selected is not the player's; pick again."
      retry
    end
  end
end

class WrongColorError < StandardError
end