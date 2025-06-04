require 'socket'
require_relative 'war_player'
require_relative 'card_deck'
require_relative 'war_game'

class WarSocketServer
  attr_accessor :server, :responses

  def initialize
    @responses = []
  end

  def port_number
    3336
  end

  def clients
    @clients ||= []
  end

  def players
    @players ||= []
  end

  def games
    @games ||= []
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = 'Random Player')
    client = server.accept_nonblock
    puts 'Client accepted'

    client.puts('Welcome to the War!')
    players.push(WarPlayer.new(player_name))
    clients.push(client)

    # associate player and client
  rescue IO::WaitReadable, Errno::EINTR
    # puts 'No client to accept'
  end

  def create_game_if_possible
    # puts players.count
    return unless players.count == 2

    game = setup_game

    clients.each do |client|
      client.puts('Game is starting...')
    end
    game
  end

  def next_round(game)
    listen_for_client_responses
    # binding.irb

    return unless self.responses.count == 2 # rubocop:disable Style/RedundantSelf

    game.play_round

    response = game.result
    # p "server #{response} rounds #{game.rounds}"
    # binding.irb
    return unless response

    clients.each do |client|
      client.puts response
    end
    self.responses = []
  end

  def run_game(game)
    loop do
      next_round(game)
    end
  end

  def stop
    server&.close
  end

  private

  def setup_game
    game = WarGame.new(CardDeck.new, players.first, players.last)
    games.push(game)
    game.start
    game
  end

  def listen_for_client_responses
    clients.each do |client|
      sleep(0.1)
      begin
        self.responses << client.read_nonblock(1000) # rubocop:disable Style/RedundantSelf
      rescue IO::WaitReadable
      end
    end
  end
end
