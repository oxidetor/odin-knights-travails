class Game
  def initialize
    @board = populate_board
    build_graph
  end

  def populate_board
    Array.new(8) { |row| Array.new(8) { |column| [row, (column - 1) + 1] } }
         .flatten(1)
         .map { |move| Node.new(move) }
  end

  def build_graph
    @board.each do |node|
      adjacent_moves = node.adjacent_moves
      node.adjacents = adjacent_moves.map { |move| find(move) }
    end
  end

  def find(move)
    @board.find { |node| node.data == move }
  end

  def knights_moves(start, finish)
    queue = [find(start)]
    finish_node = find(finish)

    visited = []
    until queue.empty?

      head_of_queue = queue.first
      visited.push(head_of_queue)

      return visited if head_of_queue.data == finish_node.data

      queue = queue + head_of_queue.adjacents - visited

    end
  end

  def to_s
    p(@board.map(&:data))
  end
end

class Node
  attr_accessor :data, :adjacents, :visited, :distance_from_source, :predecessor

  def initialize(data)
    @data = data
    @adjacents = []
    @visited = false
    @distance_from_source = 10_000
    @predecessor = nil
  end

  def valid_move(temp)
    temp.first.between?(0, 7) && temp.last.between?(0, 7)
  end

  def adjacent_moves
    steps = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    next_moves = []
    steps.each do |step|
      temp = [data.first + step.first, data.last + step.last]
      next_moves.push(temp) if valid_move(temp)
    end
    next_moves
  end

  def to_s
    "Node: #{@data}\tAdjacents: #{adjacents.map(&:data)}"
  end
end

game = Game.new
puts game.knights_moves([0, 0], [4, 3])
