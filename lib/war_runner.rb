require_relative 'war_game'

game = WarGame.new
game.start

# game.play_round until game.winner

until game.winner
  game.play_round
  puts "Round|#{game.rounds}   #{game.result}"
end
puts "Winner: #{game.winner.name}"
