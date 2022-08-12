class Node
  attr_accessor :data, :children

  def initialize(data = nil, children = nil)
    @data = data
    @children = children
  end
end

class Tree
  attr_reader :board, :root

  def initialize(start = [3, 2])
    @board = Array.new(8) { |row| Array.new(8) { |column| [row, (column - 1) + 1] } }.flatten(1)
    @root = start
  end

  def build_tree(node = @root)
    # return if node.children.include?(@root)
  end

  def next_knight_moves(current)
    steps = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    next_moves = []
    steps.each do |step|
      temp = [current.first + step.first, current.last + step.last]
      next_moves.push(temp) if board.include?(temp)
    end
    next_moves
  end
end

tree = Tree.new
p tree.next_knight_moves([7, 7])
