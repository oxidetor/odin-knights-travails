class Node
  attr_accessor :data, :neighbours, :visited, :predecessor

  def initialize(data)
    @data = data
    @neighbours = []
    @visited = false
    @predecessor = nil
  end

  def valid_move(move)
    move.first.between?(0, 7) && move.last.between?(0, 7)
  end

  def next_moves
    steps = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    steps.map do |step|
      move = [data.first + step.first, data.last + step.last]
      valid_move(move) ? move : nil
    end.compact
  end

  def to_s
    "Node: #{@data}\tNeighbours: #{neighbours.map(&:data)}"
  end
end
