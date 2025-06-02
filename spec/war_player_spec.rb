require_relative '../lib/war_player'

describe 'WarPlayer' do
  attr_writer :hand
  it 'Creates a new player with an empty hand' do
    name = "John"
    player = WarPlayer.new(name)
    expect(player.name).to eql(name)
    expect(player.hand).to be_empty
  end
  it 'tells me if the player has cards' do
    player = WarPlayer.new("John")
    expect(player.has_cards?).to eq(false)


  end

  it 'adds cards to the beginning of the deck' do
    player = WarPlayer.new("John")
    player.hand = [PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "2"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "A")]
    player.add_cards_to_bottom([PlayingCard.new("Spades", "K"), PlayingCard.new("Spades", "5")])
    expect(player.hand[0].suit).to eql("Spades")
  end

  
end
