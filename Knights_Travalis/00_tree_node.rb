
class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    @parent.children.reject! {|c| c==self} if @parent != nil #remove child from old parent's children array
    @parent = new_parent
    @parent.children << self if new_parent != nil #add child to new parent's children array if new parent isn't nil  
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "error" if !children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if target_value == self.value
    @children.each do |child|
      node = child.dfs(target_value)
      return node if !node.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      (queue.push(node.children)).flatten! #if !node.children.empty? #&& !node.children.nil?
    end
    nil
  end

end