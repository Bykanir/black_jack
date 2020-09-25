# frozen_string_literal: true

class Deck
  CARDS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[+ <> ^ <3].freeze

  attr_accessor :deck
  attr_reader :points

  def initialize
    @deck = build_deck
  end

  def get_card(player)
    card = deck.sample
    player.cards << card
    delete_card(card)
  end

  private

  def delete_card(card)
    deck.delete(card)
  end

  def build_deck
    CARDS.map do |card|
      SUITS.collect { |suit| card + suit }
    end.flatten
  end
end
