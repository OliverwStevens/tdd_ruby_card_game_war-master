require_relative 'war_player'
require_relative 'card_deck'
class WarGame
  attr_reader :player1, :player2, :deck
  attr_accessor :rounds, :result

  def initialize(deck = CardDeck.new, player1 = WarPlayer.new('Player1'), player2 = WarPlayer.new('Player2'))
    @player1 = player1
    @player2 = player2
    @deck = deck
    @rounds = 0
    @result = ''
  end

  def start
    deck.shuffle!

    while deck.has_cards?
      player1.hand.push(deck.deal)
      player2.hand.push(deck.deal)
    end
  end

  def play_round(cards = [])
    player1_card, player2_card = init_round(cards)

    if player1.has_cards? && player2.has_cards?
      calculate_round(cards, player1_card, player2_card)
    else
      self.result = "#{!player1.has_cards? ? player1.name : player2.name} has run out of cards"
    end
  end

  def winner
    return player1 unless player2.has_cards?

    player2 unless player1.has_cards?
  end

  private

  def init_round(cards)
    player1_card = player1.play_card
    player2_card = player2.play_card
    cards.push(player1_card, player2_card).shuffle!

    self.rounds += 1
    [player1_card, player2_card]
  end

  def calculate_round(cards, player1_card, player2_card)
    if player1_card.value > player2_card.value

      handle_winner(player1, player1_card, player2_card, cards)

    elsif player1_card.value < player2_card.value

      handle_winner(player2, player2_card, player1_card, cards)
    else
      handle_tie(player1_card, player2_card, cards)
    end
  end

  def message(player, card_1, card_2)
    if player.nil?
      self.result = "Hot diggity dog! It's a tie between #{card_1.rank} of #{card_1.suit} and a #{card_2.rank} of #{card_2.suit}"
    else
      self.result = "#{player.name}'s wins the round with a #{card_1.rank} of #{card_1.suit} vs a #{card_2.rank} of #{card_2.suit}"

    end
  end

  def handle_winner(player, player_card_1, player_card_2, cards)
    message(player, player_card_1, player_card_2)
    add_cards_to_bottom(player, cards)
    player
  end

  def handle_tie(player1_card, player2_card, cards)
    message(nil, player1_card, player2_card)
    play_round(cards)
  end

  def add_cards_to_bottom(player, cards)
    player.add_cards_to_bottom(cards)
  end
end
