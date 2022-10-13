require_relative 'square.rb'

#This class is initialized with a starting and ending move on a chess board, for a knight to traverse. It will create an undirected graph and find the quickest path for the knight to travel from Point A to Point B.
class KnightGraph

  attr_reader :start, :finish

  attr_accessor :graph

  @@ALL_MOVES = [[2, -1], [2, 1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

  def initialize(start, finish)
    @graph = move_set(start)
    @start = start
    @finish = finish
    self.sequence
  end

  private

    def sequence
      knight_sequence = []
      knight_sequence << self.bfs
      trace_last_move_to_first_move(knight_sequence)
      print_sequence(knight_sequence)
    end

    def trace_last_move_to_first_move(knight_sequence)
      knight_sequence.each do |move|
        knight_sequence << move.parent unless move.parent == nil
      end
    end

    def print_sequence(knight_sequence)
      puts "Find the moves for a knight to get from square #{self.start} to square #{self.finish}: "
      knight_sequence.reverse_each { |move| puts "#{move.position}" }
      puts "The fastest sequence takes #{knight_sequence.length - 1} moves."
    end

    #Most number of moves needed is 6. It is temporally expensive to search more moves than this.
    def move_set(start_move, counter = 6)
      return Square.new(start_move) if (start_move == self.finish || counter == 0)
      counter -= 1
      square = Square.new(start_move)
      valid_moves = []
      add_moves(start_move, valid_moves)
      move_recursion_call(square, valid_moves, counter)
      set_square_parent(square)
      return square
    end

    def add_moves(start_move, valid_moves)
      @@ALL_MOVES.each do |move|
        add_x = move[0] + start_move[0]
        add_y = move[1] + start_move[1]
        if (add_x >= 1 && add_x < 9 && add_y >= 1 && add_y < 9)
          valid_moves << [add_x, add_y]
        end
      end
    end

    def move_recursion_call(square, valid_moves, counter)
      valid_moves.each do |move|
        square.moves << move_set(move, counter)
      end
    end

    def set_square_parent(square)
      square.moves.each do |move|
        move.parent = square
      end
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