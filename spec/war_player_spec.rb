require_relative '../lib/war_player'

describe 'WarPlayer' do
  attr_writer :hand

  it 'Creates a new player with an empty hand' do
    name = 'John'
    player = WarPlayer.new(name)
    expect(player.name).to eql(name)
    expect(player.hand).to be_empty
  end
  it 'tells me if the player has cards' do
    player = WarPlayer.new('John')
    expect(player.has_cards?).to eq(false)
  end

  it 'adds cards to the beginning of the deck' do
    player = WarPlayer.new('John')
    player.hand = [PlayingCard.new('♥', 'A'), PlayingCard.new('♥', '2'), PlayingCard.new('♥', 'A'),
                   PlayingCard.new('♥', 'A')]
    player.add_cards_to_bottom([PlayingCard.new('♠', 'K'), PlayingCard.new('♠', '5')])
    expect(player.hand[0].suit).to eql('♠')
  end

  it 'removes a card' do
    player = WarPlayer.new('John')
    player.hand = [PlayingCard.new('♥', 'A')]
    expect(player.play_card.suit).to eql('♥')
    expect(player.has_cards?).to eq(false)
  end
end
