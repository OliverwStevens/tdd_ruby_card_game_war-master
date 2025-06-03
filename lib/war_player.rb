class WarPlayer
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def has_cards?
    hand.any?
  end

  def add_cards_to_bottom(cards)
    cards.each do |card|
      hand.unshift(card)
    end
  end

  def play_card
    hand.pop
  end

  def card_count
    hand.count
  end
end
