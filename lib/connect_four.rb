#!/usr/bin/env ruby
require_relative 'terminal_interface'
require_relative 'board'

class ConnectFour
  def initialize(interface=TerminalInterface)
    @board = Board.new
    @interface = interface.new(board)
  end

  def play
    interface.setup_game

    player = 1

    loop do
      move = interface.get_move(player)
      status = board.update(player, move)
      interface.display

      if status == :win
        interface.win(player)
      elsif status == :tie
        interface.tie
      end

      if [:win, :tie].include? status
        return interface.play_again? ? :again : :finish
      end

      player = player == 1 ? 2 : 1
    end
  end

  def reset_game
    @board = Board.new
    interface.update_board_instance(board)
  end

  private

  attr_reader :interface, :board
end

game = ConnectFour.new

loop do
  game_status = game.play

  break if game_status != :again
  game.reset_game
end
