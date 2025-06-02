class CardDeck
  attr_reader :cards_left
  def cards_left
    @cards_left ||= 52
  end

  def deal
    cards_left
    @cards_left -= 1
  end
end
