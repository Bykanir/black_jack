# frozen_string_literal: true

require_relative 'player'

class Gamer < Player
  attr_reader :name

  def initialize
    super
    @name = gets.chomp
  end
end
