class Hand

  attr_reader :cards
  attr_accessor :points

  def initialize
    @cards =[]
    @points = 0
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

  def cleaning
    cards.clear
    points = 0
  end
end