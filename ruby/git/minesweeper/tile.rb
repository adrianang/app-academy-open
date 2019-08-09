class Tile
  attr_accessor :mined, :neighbors, :board, :position_on_board

  def initialize(board)
    @mined = nil
    @flagged = false
    @revealed = false
    @neighbors = []
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

  def find_neighbors
    check_rows = @position_on_board[0]
    check_cols = @position_on_board[1]

    (check_rows - 1..check_rows + 1).each do |row|
      (check_cols - 1..check_rows + 1).each do |col|
        @neighbors << [row, col] if [row, col] != @position_on_board
      end
    end
  end

  def neighbor_mine_count
    mine_count = 0

    @neighbors.each do |pos|
      mine_count += 1 if self.board[pos.first][pos.last].mined
    end

    mine_count
  end
end