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
      move > 0 ? (return move) : (puts "Not a valid column, try again")
    end
  end

  def display
    system 'clear'

    board.rows.times do
      board.columns.times do
        print '|_'
      end

      puts '|'
    end

    board.columns.times { |t| print " #{t+1}" }

    2.times { puts }
  end


  private

  attr_reader :board
end
