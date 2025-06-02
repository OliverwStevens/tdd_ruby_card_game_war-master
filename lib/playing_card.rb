 class PlayingCard
  attr_reader :suit, :rank

   SUIT = ['H', 'D', 'S', 'C']
   def initialize(suit, rank)
     @suit = suit
     @rank = rank
   end
 end
