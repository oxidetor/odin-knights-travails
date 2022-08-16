class Node
  attr_accessor :data, :neighbours, :visited, :predecessor

  def initialize(data)
    @data = data
    @neighbours = []
    @visited = false
    @predecessor = nil
  end

  def next_moves
    steps = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    steps.map do |step|
      move = [data.first + step.first, data.last + step.last]
      valid_move(move) ? move : nil
    end.compact
  end

  def valid_move(move)
    move.first.between?(0, 7) && move.last.between?(0, 7)
  end

  def reset_node
    @visited = false
    @predecessor = nil
  end
end
