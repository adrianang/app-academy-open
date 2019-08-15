require_relative "polytreenode"

class KnightPathFinder
  def initialize(root_node)
    @root_node = PolyTreeNode.new(root_node)

    # self.build_move_tree
  end
end