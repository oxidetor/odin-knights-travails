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
      next_moves = node.next_moves
      node.neighbours = next_moves.map { |move| find(move) }
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

      queue = queue + head_of_queue.neighbours - visited

    end
  end

  def to_s
    p(@board.map(&:data))
  end
end

class Node
  attr_accessor :data, :neighbours, :visited, :distance_from_source, :predecessor

  def initialize(data)
    @data = data
    @neighbours = []
    @visited = false
    @distance_from_source = 10_000
    @predecessor = nil
  end

  def valid_move(temp)
    temp.first.between?(0, 7) && temp.last.between?(0, 7)
  end

  def next_moves
    steps = [[-1, -2], [-1, 2], [1, -2], [1, 2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    next_moves_arr = []
    steps.each do |step|
      temp = [data.first + step.first, data.last + step.last]
      next_moves_arr.push(temp) if valid_move(temp)
    end
    next_moves_arr
  end

  def to_s
    "Node: #{@data}\tneighbours: #{neighbours.map(&:data)}"
  end
end

game = Game.new
puts game.knights_moves([0, 0], [4, 3])
