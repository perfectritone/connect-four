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

        break
      end

      player = player == 1 ? 2 : 1
    end
  end

  private

  attr_reader :interface, :board
end

ConnectFour.new.play
