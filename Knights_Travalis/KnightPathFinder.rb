require_relative "00_tree_node"

class KnightPathFinder

  attr_reader :children, :considered_positions

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      front = queue.shift
      new_move_positions(front.value).each do |pos|
        child_node = PolyTreeNode.new(pos)
        front.add_child(child_node)
        queue << child_node
      end
    end
    
  end

  def self.valid_moves(pos)
    x, y = pos
    moves = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    all_moves = []
    moves.each do |move|
      all_moves << [x + move.first, y + move.last]
    end
    all_moves.select do |move| 
      move.first >= 0 && move.first < 8 && move.last >= 0 && move.last < 8
    end
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos)
    ret = []
    new_positions.each do |coordinate|
      if !@considered_positions.include?(coordinate)
        @considered_positions << coordinate
        ret << coordinate
      end
    end
    ret
  end


end