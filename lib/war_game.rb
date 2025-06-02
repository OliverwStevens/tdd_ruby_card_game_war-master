 require_relative 'war_player'
 require_relative 'card_deck'
 class WarGame
  attr_reader :player1, :player2, :deck
   def initialize
    @player1 = WarPlayer.new
    @player2 = WarPlayer.new
    @deck = CardDeck.new

    #while @deck.has_cards? do
     
    #end
   end

   
 end
