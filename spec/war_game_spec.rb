require_relative '../lib/war_game'

describe 'WarGame' do
  it "creates all the required components" do
    game = WarGame.new
    expect(game.player1).to_not eql(nil)
    expect(game.player2).to_not eql(nil)
    expect(game.deck).to_not eql(nil)

  end

  it "deals the deck to the players" do
    game = WarGame.new
    game.start
    expect(game.player1.hand.count).to eql(26)
    expect(game.player2.hand.count).to eql(26)

  end

  it "starts the game" do
    game = WarGame.new
    game.start
  end
end
