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
    return :invalid if column >= columns || column < 0

    reversed_row_index = board.reverse.find_index { |row| row[column].nil? }
    if reversed_row_index
      row = -1 - reversed_row_index
    else
      return :invalid
    end

    board[row][column] = player

    win?(player) ? :win : :ok
  end

  private

  def new_board
    Array.new(self.class.rows) { Array.new(self.class.columns) }
  end

  attr_writer :board

  def win?(player)
    # row
    board.reverse_each do |row|
      return true if four_in_a_row?(row, player)
    end

    # column
    columns.times do |n|
      column = board.map { |row| row[n] }

      return true if four_in_a_row?(column, player)
    end

    false
  end

  def four_in_a_row?(arr, elem)
    arr.chunk { |i| i == elem }.
      find { |chunk| chunk[0] && chunk[1].length == 4 }
  end
end
