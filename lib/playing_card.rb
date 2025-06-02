 class PlayingCard
  attr_reader :suit, :rank

   SUIT = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
   RANK = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
   def initialize(suit, rank)
     @suit = suit
     @rank = rank
   end

   def value
     RANK.index(rank)
   end
 end
