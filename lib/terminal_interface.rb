class TerminalInterface

  def initialize(board)
    @board = board
  end

  def setup_game
    system 'clear'

    puts "Welcome to a friendly game of Connect Four!!!"
    5.times { puts }

    display
  end

  def get_move(player_num)
    loop do
      puts "Player #{player_num}, in which column do you choose to place your piece?"
      move = gets.chomp.to_i

      # index on display starts a 1. move-1 shifts to 0.
      move > 0 ? (return move-1) : (puts "Not a valid column, try again")
    end
  end

  def display
    system 'clear'

    board.board.each do |r|
      r.each do |c|
        piece = c || '_' # nil => an empty space
        print "|#{piece}"
      end

      puts '|'
    end

    puts "#{'_' * board.columns * 2}_"
    board.columns.times { |t| print " #{t+1}" }

    2.times { puts }
  end

  def win(player_num)
    puts "CONGRATULATIONS PLAYER #{player_num}!!!!!!!\n\nYOU'VE WON!!!!!!!!"
  end

  private

  attr_reader :board
end
