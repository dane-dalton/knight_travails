require_relative 'square.rb'

class RunMoves

  attr_reader :starting_square, :ending_square

  attr_accessor :knight_square, :queue

  def initialize(starting_square, ending_square)
    @starting_square = starting_square
    @ending_square = ending_square
    @knight_square = BoardSquare.new(starting_square)
    @queue = []
  end

  def knight_moves
    knight_bfs()
    print_sequence(create_knight_history())
  end

  private
    def knight_bfs
      until @knight_square.position == @ending_square
        @knight_square.get_moves.each do |move|
          queue << BoardSquare.new(move, @knight_square)
        end
        @knight_square = @queue.shift #ruby's version of dequeue
      end
    end

    def create_knight_history
      knight_history = []
      until @knight_square.parent == nil
        knight_history << @knight_square.position
        @knight_square = @knight_square.parent
      end
      return knight_history << @knight_square.position #add the last node that has no parent
    end

    def print_sequence(knight_history)
      puts "Find the moves for a knight to get from square #{@starting_square} to square #{@ending_square}: "
      knight_history.reverse_each { |move| puts "#{move}" }
      puts "The fastest sequence takes #{knight_history.length - 1} moves."
    end
end

starting_square = [10, 9]
ending_square = [1, 1]
x = RunMoves.new(starting_square, ending_square)
x.knight_moves