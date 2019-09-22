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
    self.display.render
    self.display.cursor.get_input
  end
end