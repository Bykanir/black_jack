# frozen_string_literal: true

require_relative 'player'

class Dealer < Player
  attr_reader :name

  def initialize
    super
    @name = 'Dealer'
  end

  def hide_cards
    puts 'Dealer'
    puts "Cards: #{(hand.cards.map { '* ' })}"
  end

  def move(deck)
    puts 'Dealer move'
    if hand.points < 17 && hand.cards.size < 3
      puts 'Dealer draws card'
      deck.get_card(self)
      hide_cards
    else
      puts 'Dealer pass'
    end
  end
end
