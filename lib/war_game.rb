 require_relative 'war_player'
 require_relative 'card_deck'
 class WarGame
  attr_reader :player1, :player2, :deck
   def initialize
    @player1 = WarPlayer.new("Player1")
    @player2 = WarPlayer.new("Player2")
    @deck = CardDeck.new

    @winner = nil
   end

   def start
    @deck.shuffle!

    while @deck.has_cards? do
     @player1.hand.push(@deck.deal)
     @player2.hand.push(@deck.deal)
    end
   end

   def play_round(cards)
     #each pop, compare value, add BOTH cards to BOTTOM
     #of winner's deck, if tie, do once more
     return unless @player1.has_cards? && @player2.has_cards?
     player1_card = @player1.hand.pop
     player2_card = @player2.hand.pop

     p @player1.hand.count
     p @player2.hand.count
     cards ||= []

     cards.push(player1_card, player2_card)
     p cards

     if player1_card.value > player2_card.value
      p "win p1 #{player1_card.value}  p2 #{player2_card.value}"
       @player1.hand += cards

     elsif player1_card.value < player2_card.value
      p "lose p1#{player1_card.value}  p2#{player2_card.value}"

      @player2.hand += cards

     else
      p "tie p1#{player1_card.value}  p2#{player2_card.value}"

      play_round(cards)
     end

   end

   
 end
