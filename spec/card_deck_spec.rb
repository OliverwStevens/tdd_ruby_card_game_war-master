require_relative '../lib/card_deck'
require_relative 'spec_helper'

describe 'CardDeck' do
  it 'Should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should deal the top card' do
    deck = CardDeck.new
    card = deck.deal
    expect(card).to_not be_nil
    expect(deck.cards_left).to eq 51
  end

  it 'should contain playing card objects' do
    deck = CardDeck.new
    expect(deck.cards[0]).to be_a(PlayingCard)
  end

  it 'Should shuffle the deck' do
    deck = CardDeck.new
    deck.shuffle!
    expect(deck.cards).to_not contain_exactly(deck.cards)
  end

  it 'checks to see if the deck has any cards' do
    deck = CardDeck.new
    expect(deck.has_cards?).to eql(true)

    deck.cards = []

    expect(deck.has_cards?).to eql(false)
  end
end
