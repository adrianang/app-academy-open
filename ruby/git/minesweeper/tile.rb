class Tile
  attr_accessor :mined, :neighbors, :board, :position_on_board

  def initialize(board)
    @mined = nil
    @flagged = false
    @revealed = false
    @neighbors = nil
    @board = board
    @position_on_board = nil
  end

  def inspect
    { 'mined' => @mined, 'flagged' => @flagged, 'revealed' => @revealed, 'neighbors' => @neighbors, 'position_on_board' => @position_on_board }.inspect
  end

  def reveal
    if !self.revealed
      @revealed = true
    end
  end

  def neighbors

  end

  def neighbor_mine_count
    mine_count = 0

    (0...9).each do |row|
    end

    mine_count
  end
end