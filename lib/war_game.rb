 require_relative 'war_player'
 require_relative 'card_deck'
 class WarGame
  attr_reader :player1, :player2, :deck
  attr_accessor :winner
   def initialize
    @player1 = WarPlayer.new("Player1")
    @player2 = WarPlayer.new("Player2")
    @deck = CardDeck.new

    @winner = nil
   end

   def start
    deck.shuffle!

    while deck.has_cards? do
     player1.hand.push(deck.deal)
     player2.hand.push(deck.deal)
    end
   end

   def play_round(cards)
     check_winner
     return if winner
     #each pop, compare value, add BOTH cards to BOTTOM
     #of winner's deck, if tie, do recursively more
     player1_card = player1.hand.pop
     player2_card = player2.hand.pop

     cards ||= []

     cards.push(player1_card, player2_card)

     if player1_card.value > player2_card.value
      puts "#{player1.name}'s wins the round with a #{player1_card.rank} of #{player1_card.suit} vs a #{player2_card.rank} of #{player2_card.suit}"
       player1.add_cards_to_bottom(cards)

     elsif player1_card.value < player2_card.value
      puts "#{player2.name}'s wins the round with a #{player2_card.rank} of #{player2_card.suit} vs a #{player1_card.rank} of #{player1_card.suit}"

      player2.add_cards_to_bottom(cards)

     else
      puts "Hot diggity dog! It's a tie between #{player1_card.rank} of #{player1_card.suit} and a #{player2_card.rank} of #{player2_card.suit}"

      play_round(cards)
     end



   end

   def check_winner
    if !player2.has_cards?
      winner = player1
    elsif !player1.has_cards?
      winner = player2
    end
   end
 end
