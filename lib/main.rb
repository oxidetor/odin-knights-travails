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
      node.neighbours = node.next_moves.map { |move| find(move) }
    end
  end

  def find(move)
    @board.find { |node| node.data == move }
  end

  def knights_moves(start, finish)
    queue = [find(start)]
    finish_node = find(finish)
    process_queue(queue)
    shortest_path_reversed(find(start), finish_node)
  end

  # TODO: Refactor process_queue
  def process_queue(queue)
    until queue.empty?
      head_of_queue = queue.first
      head_of_queue.neighbours.each do |neighbour|
        next if neighbour.visited

        queue.push(neighbour)
        neighbour.visited = true
        neighbour.predecessor = head_of_queue
      end
      queue = queue.drop(1)
    end
  end

  # TODO: Refactor shortest_path_reversed
  def shortest_path_reversed(start_node, finish_node)
    path = []
    at = finish_node
    until at.nil? || at == start_node
      path.push(at.data)
      at = at.predecessor
    end
    path.push(at.data)
    reset_nodes
    path.reverse
  end

  def reset_nodes
    @board.each do |node|
      node.visited = false
      node.predecessor = nil
    end
  end

  def to_s
    p(@board.map(&:data))
  end
end

class Node
  attr_accessor :data, :neighbours, :visited, :predecessor

  def initialize(data)
    @data = data
    @neighbours = []
    @visited = false
    @predecessor = nil
  end

  # TODO: Rename temp
  def valid_move(temp)
    temp.first.between?(0, 7) && temp.last.between?(0, 7)
  end

  # TODO: Refactor next_moves
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
    "Node: #{@data}\tNeighbours: #{neighbours.map(&:data)}"
  end
end

game = Game.new
p game.knights_moves([0, 0], [7, 7])
p game.knights_moves([0, 0], [4, 3])
p game.knights_moves([2, 2], [5, 5])
