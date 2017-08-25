class Board
  def self.rows() 7 end
  def self.columns() 6 end
  def rows() self.class.rows end
  def columns() self.class.columns end

  def initialize
    @board = new_board
  end

  attr_reader :board

  def update(player, column)
    board[-1][column] = player
  end

  private

  def new_board
    Array.new(self.class.rows, Array.new(self.class.columns))
  end

  attr_writer :board
end

# player pieces
# display board, move
