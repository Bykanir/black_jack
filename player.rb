# frozen_string_literal: true

class Player
  attr_reader :cards
  attr_accessor :points, :money

  def initialize
    @cards = []
    @points = 0
    @money = 100
  end

  def score
    self.points = 0
    cards.each do |card|
      self.points += if card.include?('A')
                       self.points < 11 ? 11 : 1
                     else
                       card.to_i.zero? ? 10 : card.to_i
                     end
    end
  end

  def lose_money
    self.money -= 10
  end

  def win_money
    self.money += 10
  end

  def cleaning
    cards.clear
    self.points = 0
  end
end
