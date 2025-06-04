require_relative 'war_game'

game = WarGame.new
game.start

# game.play_round until game.winner

until game.winner
  game.play_round
  puts game.result
end
puts "Winner: #{game.winner.name}"
