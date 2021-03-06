require_relative "polytreenode"

class KnightPathFinder
  attr_accessor :root_node

  def self.valid_moves(pos)
    valid_moves = []

    ((pos[0] - 1)..(pos[0] + 1)).step(2).each do |idx1|
      ((pos[1]- 2)..(pos[1] + 2)).step(4).each do |idx2|
        valid_moves << [idx1, idx2]
      end  
    end

    ((pos[0] - 2)..(pos[0] + 2)).step(4).each do |idx1|
      ((pos[1] - 1)..(pos[1] + 1)).step(2).each do |idx2|
        valid_moves << [idx1, idx2]
      end
    end

    selected_valid_moves = valid_moves.select { |move| (0..8).include?(move[0]) && (0..8).include?(move[1]) }
    selected_valid_moves
  end

  def initialize(root_node)
    @root_node = PolyTreeNode.new(root_node)
    @considered_positions = [root_node]
    self.build_move_tree
  end

  def new_move_positions(pos)
    new_moves = []
    selected_new_moves = KnightPathFinder.valid_moves(pos).select { |valid_move| !@considered_positions.include?(valid_move) }
    @considered_positions += selected_new_moves
    selected_new_moves
  end

  def build_move_tree
    queue = [@root_node]

    until queue.empty?
      node = queue.shift
      new_moves = self.new_move_positions(node.value)

      new_moves.each do |move|
        new_move_node = PolyTreeNode.new(move)
        node.add_child(new_move_node)
        queue << new_move_node
      end
    end

    true
  end

  def find_path(end_pos)
    found_node = self.root_node.bfs(end_pos)
    self.trace_path_back(found_node)
  end

  def trace_path_back(node)
    path = []

    until node.parent.nil?
      path << node.value
      node = node.parent
    end

    path << @root_node.value
    path.reverse
  end
end