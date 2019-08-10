class Tile
  attr_accessor :mined, :flagged, :revealed, :neighbors, :board, :position_on_board

  def initialize(board)
    @mined = nil
    @flagged = false
    @revealed = false
    @neighbors = []
    @board = board
    @position_on_board = nil
  end

  def inspect
    { 'mined' => @mined,
      'flagged' => @flagged,
      'revealed' => @revealed,
      'neighbors' => @neighbors,
      'position_on_board' => @position_on_board 
    }.inspect
  end

  def flag
    if !self.flagged
      @flagged = true
    else
      @flagged = false
    end
  end

  def reveal
    if !self.revealed
      @revealed = true

      if self.neighbor_mine_count == 0
        self.neighbors.each do |pos|
          @board[pos[0]][pos[1]].reveal
        end
      end
    end
  end

  def find_neighbors
    tile_neighbors = []
    center_row = @position_on_board[0]
    center_col = @position_on_board[1]

    ((center_row - 1)..(center_row + 1)).each do |row|
      ((center_col - 1)..(center_col + 1)).each do |col|
        tile_neighbors << [row, col] if [row, col] != [center_row, center_col]
      end
    end
    
    selected_tile_neighbors = tile_neighbors.select { |neighbor| ((0...9).include?(neighbor[0]) && (0...9).include?(neighbor[1])) }
    self.neighbors = selected_tile_neighbors
    true
  end

  def neighbor_mine_count
    mine_count = 0

    self.neighbors.each do |pos|
      mine_count += 1 if @board[pos.first][pos.last].mined
    end

    mine_count
  end
end