class BoardSquare

  attr_reader :position, :parent

  ALL_MOVES = [[2, -1], [2, 1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
  BOARD_SIZE = [1, 8]

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
  end

  def get_moves
    ALL_MOVES.map { |move| [move[0] + @position[0], move[1] + @position[1]] }.keep_if { |move| valid_move?(move) }
  end

  private

    def valid_move?(move)
      move[0].between?(BOARD_SIZE[0], BOARD_SIZE[1]) && move[1].between?(BOARD_SIZE[0], BOARD_SIZE[1])
    end
end