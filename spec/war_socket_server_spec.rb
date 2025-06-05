require_relative '../lib/war_socket_server'
require_relative '../lib/mock_war_socket_client'
require_relative 'spec_helper'
describe WarSocketServer do
  let(:client1) { MockWarSocketClient.new(@server.port_number) }
  let(:client2) { MockWarSocketClient.new(@server.port_number) }

  before(:each) do
    @clients = []
    @server = WarSocketServer.new
    @server.start
    sleep 0.1 # Ensure server is ready for clients
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  it 'is not listening on a port before it is started' do
    @server.stop
    expect { MockWarSocketClient.new(@server.port_number) }.to raise_error(Errno::ECONNREFUSED)
  end

  it 'accepts new clients and starts a game if possible' do
    integrate_client(client1, 'Player 1')

    expect(@server.games.count).to be 0

    integrate_client(client2, 'Player 2')

    expect(@server.games.count).to be 1
  end

  it 'sends a welcome message' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')

    expect(client1.capture_output).to match(/welcome/i)
  end

  it 'sends a message to both clients when there are two clients' do
    integrate_client(client1, 'Player 1')

    integrate_client(client2, 'Player 2')

    expect(client1.capture_output).to match(/ready/i)
    expect(client2.capture_output).to match(/ready/i)
  end

  it 'waits for input from both users before moving onto the next round' do
    both_clients_integrate_and_input

    @server.next_round(@server.games.first)

    expect(client1.capture_output).to match(/of/i)
    expect(client2.capture_output).to match(/of/i)

    # handles ties
    expect(@server.games.first.rounds).to_not eql(0)
  end

  it 'should not play game without both players' do
    integrate_client(client1, 'Player 1')

    integrate_client(client2, 'Player 2')

    client1.provide_input('Ready!')

    @server.create_game_if_possible

    @server.next_round(@server.games.first)

    # handles ties
    expect(@server.games.first.rounds).to eql(0)
  end

  it 'plays multiple rounds' do
    both_clients_integrate_and_input

    do_next_round

    # handles ties
    expect(@server.games.first.rounds).to_not eql(0)

    client1.provide_input('Ready!')
    client2.provide_input('Ready!')

    do_next_round

    # handles ties
    expect(@server.games.first.rounds).to_not eql(1)
  end

  # Add more tests to make sure the game is being played
  # For example:
  #   make sure the mock client gets appropriate output
  #   make sure the next round isn't played until both clients say they are ready to play
  #   ...
end

private

def integrate_client(client, name)
  @clients.push(client)
  @server.accept_new_client(name)
  @server.create_game_if_possible
end

def both_clients_integrate_and_input(input = 'Ready!')
  integrate_client(client1, 'Player 1')

  integrate_client(client2, 'Player 2')

  client1.provide_input(input)
  client2.provide_input(input)
end

def do_next_round
  @server.next_round(@server.games.first)

  expect(client1.capture_output).to match(/of/i)
  expect(client2.capture_output).to match(/of/i)
end
