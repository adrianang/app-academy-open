class Tile
  attr_accessor :mined

  def initialize(board)
    @mined = nil
    @flagged = false
    @revealed = false
  end
end