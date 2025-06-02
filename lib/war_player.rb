 class WarPlayer
  attr_reader :name
  attr_accessor :hand
  def initialize(name)
    @name = name
    @hand = []
  end

  def has_cards?
    @hand.any?
  end
  
 end
