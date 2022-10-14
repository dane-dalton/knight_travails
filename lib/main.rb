require_relative 'run_moves.rb'

def knight_travails(starting_square, ending_square)
  knight = RunMoves.new(starting_square, ending_square)
  knight.knight_moves
end

starting_square = [1, 7]
ending_square = [1, 1]
knight_travails(starting_square, ending_square)