# frozen_string_literal: true

require_relative 'requireable'

class App
  attr_reader :gamer, :dealer, :deck, :users, :exit

  def initialize
    @gamer = Gamer.new
    @dealer = Dealer.new
    @deck = Deck.new
    @users = [gamer, dealer]
    @exit = 0
  end

  def start_game
    users.each(&:cleaning)
    puts "You bank - #{gamer.money}"
    puts 'Give out cards'
    distribution_cards
    show_player_cards(gamer)
    dealer.hide_cards
  end

  def game(random)
    case random
    when 1
      game_random_one
    when 2
      game_random_two
    end
  end

  def play_again
    puts 'Want to play more?'
    puts '1 - Play!'
    puts "2 - That's enough!"
  end

  private

  def game_random_one
    loop do
      gamer_move
      break if exit == 1

      dealer.move(deck)
    end
  end

  def game_random_two
    loop do
      dealer.move(deck)
      gamer_move
      break if exit == 1
    end
  end

  def show_options
    puts 'You move!'
    puts 'What are we doing?'
    puts '1 - Skip move'
    if gamer.cards.size < 3
      puts '2 - Add card'
    else
      puts 'Add card is not available'
    end
    puts '3 - Open cards'
  end

  def distribution_cards
    users.each do |user|
      2.times { deck.get_card(user) }
    end
    users.each(&:score)
  end

  def gamer_move
    show_options
    gamer_action(gets.chomp.to_i)
  end

  def gamer_action(choice)
    case choice
    when 1
      puts 'You pass'
    when 2
      deck.get_card(gamer)
      show_player_cards(gamer)
    when 3
      end_game
    end
  end

  def end_game
    @exit = 1
    users.each(&:score)
    reveal_cards

    return puts 'Dealer won!' if gamer.points > 21
    return puts "#{gamer.name} won!" if dealer.points > 21

    winner
  end

  # rubocop:disable Metrics/AbcSize
  def winner
    if gamer.points > dealer.points
      puts "#{gamer.name} won!"
      gamer.win_money
      dealer.lose_money
      puts "You bank - #{gamer.money}"
    elsif gamer.points < dealer.points
      puts 'Dealer won!'
      dealer.win_money
      gamer.lose_money
      puts "You bank - #{gamer.money}"
    else
      puts 'Draw!'
    end
  end
  # rubocop:enable Metrics/AbcSize

  def reveal_cards
    puts 'Open all cards'
    show_player_cards(gamer)
    show_player_cards(dealer)
  end

  def show_player_cards(player)
    users.each(&:score)
    puts player.name.to_s
    puts "Cards: #{player.cards}"
    puts "Points: #{player.points}"
  end
end
