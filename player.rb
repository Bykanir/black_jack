# frozen_string_literal: true

require_relative 'hand'

class Player
  
  attr_reader :hand
  attr_accessor :money

  def initialize
    @hand = Hand.new
    @money = 100
  end
end
