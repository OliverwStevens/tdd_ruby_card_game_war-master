require_relative '../lib/war_game'

describe 'WarGame' do
  let(:p1_hand) do
    [PlayingCard.new('♥', 'A'), PlayingCard.new('♥', '2'),
     PlayingCard.new('♥', 'A'), PlayingCard.new('♥', 'A')]
  end
  let(:p2_hand) do
    [PlayingCard.new('♥', '2'), PlayingCard.new('♥', 'A'),
     PlayingCard.new('♥', 'A'), PlayingCard.new('♥', '2')]
  end

  context 'When it is created' do
    it 'creates all the required components' do
      game = WarGame.new
      expect(game.player1).to_not eql(nil)
      expect(game.player2).to_not eql(nil)
      expect(game.deck).to_not eql(nil)
    end

    it 'deals the deck to the players' do
      game = WarGame.new
      game.start
      expect(game.player1.card_count).to eql(26)
      expect(game.player2.card_count).to eql(26)
    end
  end
  context 'it tests the game' do
    it 'plays a round' do
      game = WarGame.new
      game.start
      # override the hands
      game.player1.hand = p1_hand
      game.player2.hand = p2_hand
      game.play_round
      expect(game.player1.card_count).to eql(5)
      expect(game.player2.card_count).to eql(3)
    end

    it 'checks to see if there is a winner' do
      game = WarGame.new
      game.start
      # override the hands
      game.player1.hand = [PlayingCard.new('♥', 'A')]
      game.player2.hand = [PlayingCard.new('♥', '2')]

      expect(game.winner).to be_nil

      game.play_round

      expect(game.winner).to eql(game.player1)
    end
  end
end
