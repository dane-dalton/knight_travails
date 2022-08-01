class Square

  attr_accessor :position, :moves

  def initialize(position)
    @position = position
    @moves = []
  end
end

class KnightGraph

  attr_accessor :graph, :finish

  @@ALL_MOVES = [[2, -1], [2, 1], [1, 2], [1, -2],[-1, 2], [-1, -2], [-2, 1], [-2, -1]]

  def initialize(start, finish)
    @graph = move_set(start, finish)
    @finish = finish
  end

  def move_set(start, finish, counter = 6)
    return 1 if start == finish
    return if counter == 0
    square = Square.new(start)
    valid_moves = []
    @@ALL_MOVES.each do |move|
      add_x = move[0] + start[0]
      add_y = move[1] + start[1]
      if (add_x >= 0 && add_x < 8 && add_y >= 0 && add_y < 8)
        valid_moves << [add_x, add_y]
      end
    end
    counter -= 1
    valid_moves.each do |move|
      square.moves << move_set(move, finish, counter)
    end
    return square
  end

  def bfs 
    queue = []
    queue << @graph

    queue.each do |square|
      p square
      square.moves.each do |move|
        return p "TEST RETURN" if move == 1
        queue << move
      end
    end
  end
end

def knight_moves(start, finish)
  #tree of all possible moves
  ##knight moves in an L shape
  ##cant move off the board
  ##dont move to a position that has been visited

  #perform a BFS and pick the first end move scenario
  #perform a DFS traversal to print each move taken to that move, and the number of moves


end

knight_graph = KnightGraph.new([1, 1], [3, 2])
p knight_graph.bfs