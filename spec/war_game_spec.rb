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
    game.player1.hand = [PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "2"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "A")]
    game.player2.hand = [PlayingCard.new("Hearts", "2"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "A"), PlayingCard.new("Hearts", "2")]


    game.play_round(nil)
    expect(game.player1.hand.count).to eql(5)
    expect(game.player2.hand.count).to eql(3)

    game.play_round(nil)

    expect(game.player1.hand.count).to eql(4)
    expect(game.player2.hand.count).to eql(4)
    game.play_round(nil)
  end

  it "checks to see if there is a winner" do
    game = WarGame.new
    game.start
    #override the hands
    game.player1.hand = [PlayingCard.new("Hearts", "A")]
    game.player2.hand = [PlayingCard.new("Hearts", "2")]
    
    expect(game.check_winner).to eql(nil)

    game.play_round(nil)

    expect(game.check_winner).to eql(game.player1)

  end
end
