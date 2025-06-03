 require_relative 'war_player'
 require_relative 'card_deck'
 class WarGame
  attr_reader :player1, :player2, :deck
   def initialize(deck = CardDeck.new)
    @player1 = WarPlayer.new("Player1")
    @player2 = WarPlayer.new("Player2")
    @deck = deck
   end

   def start
    deck.shuffle!

    while deck.has_cards? do
     player1.hand.push(deck.deal)
     player2.hand.push(deck.deal)
    end

    #player1.hand = [PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "2"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "A")]
    #player2.hand = [PlayingCard.new("Hearts", "2"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "2")]

   end

   def play_round(cards)
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

     #p player2.hand.count

   end

   def winner
    return player1 if !player2.has_cards?
    return player2 if !player1.has_cards?
   end
 end
