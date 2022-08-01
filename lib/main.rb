class Square

  attr_accessor :position, :moves

  def initialize(position)
    @position = position
    @possible_moves = []
  end
end



def knight_moves(start, end)
  #tree of all possible moves
  ##knight moves in an L shape
  ##cant move off the board
  ##dont move to a position that has been visited

  #perform a BFS and pick the first end move scenario
  #perform a DFS traversal to print each move taken to that move, and the number of moves


end
