require_relative 'knight_graph.rb'

def knight_moves(starting_square, ending_square)
  knight_graph = KnightGraph.new(starting_square, ending_square)
  knight_graph.sequence
end

starting_square = [7, 6]
ending_square = [1, 3]
knight_moves(starting_square, ending_square)