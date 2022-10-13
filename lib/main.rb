class Square

  attr_reader :position

  attr_accessor :moves, :parent

  def initialize(position)
    @position = position
    @moves = []
    @parent = nil
  end
end

class KnightGraph

  attr_reader :start, :finish

  attr_accessor :graph

  @@ALL_MOVES = [[2, -1], [2, 1], [1, 2], [1, -2],[-1, 2], [-1, -2], [-2, 1], [-2, -1]]

  def initialize(start, finish)
    @graph = move_set(start)
    @start = start
    @finish = finish
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

  private

  #Most number of moves needed is 6. It is temporally expensive to search more moves than this.
  def move_set(start_move, counter = 6)
    return Square.new(start_move) if start_move == self.finish
    return Square.new(start_move) if counter == 0
    counter -= 1
    square = Square.new(start_move)
    valid_moves = []
    @@ALL_MOVES.each do |move|
      add_x = move[0] + start_move[0]
      add_y = move[1] + start_move[1]
      if (add_x >= 1 && add_x < 9 && add_y >= 1 && add_y < 9)
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
      return bfs_first_finish(queue)
    end

    def bfs_first_finish(queue)
      queue.each do |square_in_queue|
        square_in_queue.moves.each do |move|
          return move if move.position == self.finish
          queue << move
        end
      end
    end
end

def knight_moves(starting_square, ending_square)
  knight_graph = KnightGraph.new(starting_square, ending_square)
  knight_graph.sequence
end

starting_square = [1, 2]

ending_square = [8, 7]

knight_moves(starting_square, ending_square)