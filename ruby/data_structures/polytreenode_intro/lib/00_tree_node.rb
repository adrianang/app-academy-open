class PolyTreeNode
  attr_accessor :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

#   def parent=(parent_node)
#     @ if parent_node.nil?
#     @parent = parent_node
#     parent_node.children << self if !parent_node.children.include?(self)
#   end
end