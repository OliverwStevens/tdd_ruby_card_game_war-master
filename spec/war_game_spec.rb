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

  it "plays a round" do
    game = WarGame.new
    game.start
    #override the hands
    game.player1.hand = [PlayingCard.new("H", "A"), PlayingCard.new("H", "2"), PlayingCard.new("H", "A"), PlayingCard.new("H", "A")]
    game.player2.hand = [PlayingCard.new("H", "2"), PlayingCard.new("H", "A"), PlayingCard.new("H", "A"), PlayingCard.new("H", "2")]


    game.play_round(nil)
    expect(game.player1.hand.count).to eql(5)
    expect(game.player2.hand.count).to eql(3)
  end
end
