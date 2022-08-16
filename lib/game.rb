require_relative './node'

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

  def knight_moves(start, finish)
    process_queue([find(start)])
    shortest_path(find(start), find(finish))
  end

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

  def shortest_path(start_node, finish_node)
    path = []
    at = finish_node
    until at == start_node
      path.push(at.data)
      at = at.predecessor
    end
    reset_nodes
    path.push(at.data).reverse
  end

  def reset_nodes
    @board.each(&:reset_node)
  end
end
