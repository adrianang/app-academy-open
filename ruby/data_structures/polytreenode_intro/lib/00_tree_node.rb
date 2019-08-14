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
end