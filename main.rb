# frozen_string_literal: true

require_relative 'interface'

puts 'Hello! What is you name?'
interface = Interface.new
puts 'Welcome to the game!'

loop do
  interface.start_game

  interface.game

  interface.play_again
  gets.chomp.to_i == 1 ? next : break
end
puts 'Good bay!'
