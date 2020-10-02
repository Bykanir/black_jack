# frozen_string_literal: true

require_relative 'card'

class Deck
  
  attr_accessor :deck
  attr_reader :points

  def initialize
    @deck = build_deck
  end

  def get_card(player)
    card = deck.sample
    player.hand.cards << card
    delete_card(card)
  end

  private

  def delete_card(card)
    deck.delete(card)
  end

  def build_deck
    Card::CARDS.map do |card|
      Card::SUITS.collect { |suit| card + suit }
    end.flatten
  end
end
