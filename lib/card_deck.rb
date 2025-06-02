class CardDeck
  attr_reader :cards_left
  attr_accessor :cards

  def initialize    
    @cards = PlayingCard::SUIT.flat_map do |suit|
      PlayingCard::RANK.map do |rank|
        PlayingCard.new(suit, rank)
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
    @cards.any?
  end
end
