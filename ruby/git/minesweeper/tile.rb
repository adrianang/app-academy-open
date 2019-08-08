class Tile
  attr_accessor :mined

  def initialize(board)
    @mined = nil
    @flagged = false
    @revealed = false
  end

  def reveal
    if !self.revealed
      @revealed = true
    end
  end

  def neighbors
  end
end