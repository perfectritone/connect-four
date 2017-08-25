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
  end
end
