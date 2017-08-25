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
    move = interface.get_move(player)
    board.update(player, move)
    interface.display
  end

  private

  attr_reader :interface, :board
end

ConnectFour.new.play
