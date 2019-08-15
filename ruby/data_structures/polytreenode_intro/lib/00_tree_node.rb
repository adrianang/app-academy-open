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

  def parent=(new_parent)
    @parent.children.delete(self) if !@parent.nil?
    @parent = new_parent

    if !new_parent.nil?
      new_parent.children << self if !new_parent.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent = nil
    raise "Not a child of this node!" if !self.children.include?(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil?
    end

    nil
  end
end