require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'Should be a card' do
    card = PlayingCard.new('H', 'A')
    expect(card).to be_a(PlayingCard)

    expect(card.suit).to eql('H')
    expect(card.rank).to eql('A')
  end

  it 'Should return the value of the card' do
    card = PlayingCard.new('H', 'A')
    expect(card.value).to eql(12)
  end
end
