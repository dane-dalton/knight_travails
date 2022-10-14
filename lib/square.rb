class BoardSquare

  attr_reader :position

  attr_accessor :moves, :parent

  def initialize(position)
    @position = position
    @moves = []
    @parent = nil
  end
end