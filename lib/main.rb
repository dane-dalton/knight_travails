class Square

  attr_accessor :position, :moves, :parent

  def initialize(position)
    @position = position
    @moves = []
    @parent = nil
  end
end

class KnightGraph

  attr_accessor :graph, :start , :finish

  @@ALL_MOVES = [[2, -1], [2, 1], [1, 2], [1, -2],[-1, 2], [-1, -2], [-2, 1], [-2, -1]]

  def initialize(start, finish)
    @graph = move_set(start)
    @start = start
    @finish = finish
  end

  def move_set(start_move, counter = 6)
    return Square.new(start_move) if start_move == self.finish
    return Square.new(start_move) if counter == 0
    counter -= 1
    square = Square.new(start_move)
    valid_moves = []
    @@ALL_MOVES.each do |move|
      add_x = move[0] + start_move[0]
      add_y = move[1] + start_move[1]
      if (add_x >= 0 && add_x < 8 && add_y >= 0 && add_y < 8)
        valid_moves << [add_x, add_y]
      end
    end

    valid_moves.each do |move|
      square.moves << move_set(move, counter)
    end
    
    unless square.moves[0].is_a?(Array)
      square.moves.each do |move|
        move.parent = square
      end
    end
    return square
  end

  def bfs 
    queue = []
    queue << @graph

    queue.each do |square|
      square.moves.each do |move|
        return move if move.position == self.finish
        queue << move
      end
    end

    return nil
  end

  def sequence
    fast_sequence = []
    fast_sequence << self.bfs

    fast_sequence.each do |move|
      fast_sequence << move.parent unless move.parent == nil
    end

    puts "Find the moves for a knight to get from square #{self.start} to square #{self.finish}: "
    fast_sequence.reverse_each { |move| puts "#{move.position}" }
    puts "The fastest sequence takes #{fast_sequence.length - 1} moves."
  end
end

def knight_moves(start, finish)
  knight_graph = KnightGraph.new(start, finish)
  knight_graph.sequence
end

square_a = [0, 1]

square_b = [6, 7]

knight_moves(square_a, square_b)