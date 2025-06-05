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
  rescue IO::WaitReadable, Errno::EINTR
    # puts 'No client to accept'
  end

  def create_game_if_possible
    return unless players.count == 2

    game = setup_game

    clients.each do |client|
      client.puts('Press enter if you are ready to start the game:')
    end

    game
  end

  def next_round(game)
    # binding.irb
    listen_for_client_responses

    return unless self.responses.count == 2 # rubocop:disable Style/RedundantSelf

    game.play_round

    output_response(game)

    # listen_for_client_responses
  end

  def run_game(game)
    next_round(game) until game.winner
    puts "Winner: #{game.winner.name}"
    # clients.each do |client|
    #   client.puts "Winner: #{game.winner.name}"
    # end
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

  def output_response(game)
    response = game.result
    return unless response

    clients.each do |client|
      client.puts "Round|#{game.rounds}   #{response}"
      client.puts('Press Enter:')
    end
    self.responses = []
  end
end
