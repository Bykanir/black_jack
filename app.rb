# frozen_string_literal: true

require_relative 'requireable'

class App

  attr_reader :gamer, :dealer, :deck, :users, :exit
  attr_accessor :bank

  def initialize
    @gamer = Gamer.new
    @dealer = Dealer.new
    @deck = Deck.new
    @users = [gamer, dealer]
    @bank = 0 
  end

  def start_game
    rate
    users.each { |user| user.hand.cleaning }
    distribution_cards
  end

  def end_game
    users.each{ |user| user.hand.score }

    winner
  end

  private

  def rate
    users.each { |user| user.money -= 10 }
    self.bank += 20
  end

  def winner
    if gamer.hand.points > 21 || dealer.hand.points > 21
      more_21
    else 
      less_21
    end
  end

  def win_money(player)
    player.money += bank
    self.bank = 0
  end

  def draw
    users.each { |user| user.money += 10}
    bank = 0
  end

  def distribution_cards
    users.each do |user|
      2.times { deck.get_card(user) }
    end
    users.each{ |user| user.hand.score }
  end

  def more_21
    if gamer.hand.points > 21
      win_money(dealer)        
    elsif dealer.hand.points > 21
      win_money(gamer)
    end
  end

  def less_21
    if gamer.hand.points > dealer.hand.points
      win_money(gamer)
    elsif gamer.hand.points < dealer.hand.points
      win_money(dealer)
    else
      draw      
    end
  end
end
