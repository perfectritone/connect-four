#!/usr/bin/env ruby
require_relative 'terminal_interface'

class ConnectFour
  def initialize(interface=TerminalInterface)
    @interface = interface.new
  end

  def play
    interface.setup_game
    move = interface.get_move(1)
  end

  private

  attr_reader :interface
end

ConnectFour.new.play
