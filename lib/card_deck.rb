class CardDeck
  attr_reader :cards_left, :cards

  def initialize
    @cards = []
    
    for suit in PlayingCard::SUIT do
      13.times do
        @cards.push(PlayingCard.new(suit, "A"))
      end
    end
  end
  def cards_left
    @cards.count ||= 52
  end

  def deal
    cards_left
    @cards.pop
  end
end
