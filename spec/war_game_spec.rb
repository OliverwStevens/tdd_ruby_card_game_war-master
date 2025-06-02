require_relative '../lib/war_game'

describe 'WarGame' do
  it "creates all the required components" do
    game = WarGame.new
    expect(game.player1).to be_a(WarPlayer)
    expect(game.player2).to be_a(WarPlayer)

    expect(game.deck).to be_a(CardDeck)

  end

  it "deals the deck to the players" do
    game = WarGame.new
    
  end
end
