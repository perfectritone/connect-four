class TerminalInterface

  def setup_game
    system 'clear'
    puts "Welcome to a friendly game of Connect Four!!!"
    5.times { puts }

    #  |_|_|
    #  |_|_|
    #  |X|O|

    board_rows = 6
    board_columns = 7

    board_rows.times do
      board_columns.times do
        print '|_'
      end

      puts '|'
    end

    board_columns.times { |t| print " #{t+1}" }

    2.times { puts }
  end

  def get_move(player_num)
    puts "Player #{player_num}, in which column do you choose to place your piece?"
    gets.chomp
  end
end
