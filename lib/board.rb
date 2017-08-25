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
      connect_four = row.chunk { |i| i == player }.
        find { |chunk| chunk[0] && chunk[1].length == 4 }

      return true if connect_four
    end

    # column
    columns.times do |n|
      column = board.map { |row| row[n] }
      connect_four = column.chunk { |i| i == player }.
        find { |chunk| chunk[0] && chunk[1].length == 4 }

      return true if connect_four
    end

    false
  end
end
