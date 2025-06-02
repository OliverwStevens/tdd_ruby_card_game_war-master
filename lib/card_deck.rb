class CardDeck
  attr_reader :cards_left
  attr_accessor :cards

  def initialize
    @cards = []
    
    for suit in PlayingCard::SUIT do
      for rank in PlayingCard::RANK do
        @cards.push(PlayingCard.new(suit, rank))
      end
    end
  end
  def cards_left
    @cards.count ||= 52
  end

  def deal
    @cards.pop
  end

  def shuffle
    @cards.shuffle
  end

  def has_cards?
    if @cards.count > 0
      true
    else
      false
    end
  end
end
