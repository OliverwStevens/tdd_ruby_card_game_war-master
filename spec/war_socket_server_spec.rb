require_relative '../lib/war_socket_server'
require_relative '../lib/mock_war_socket_client'

describe WarSocketServer do
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
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    @server.create_game_if_possible
    expect(@server.games.count).to be 0
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client('Player 2')
    @server.create_game_if_possible
    expect(@server.games.count).to be 1
  end

  it 'sends a welcome message' do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    expect(client1.capture_output).to match(/welcome/i)
  end

  it 'sends a message to both clients when there are two clients' do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client('Player 2')
    @server.create_game_if_possible

    expect(client1.capture_output).to match(/starting/i)
    expect(client2.capture_output).to match(/starting/i)
  end

  it 'waits for input from both users before moving onto the next round' do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client('Player 2')

    client1.provide_input('Ready!')
    client2.provide_input('Ready!')

    @server.create_game_if_possible

    @server.run_game(@server.games.first)

    expect(client1.capture_output).to match(/of/i)
    expect(client2.capture_output).to match(/of/i)

    # handles ties
    expect(@server.games.first.rounds).to_not eql(0)
  end

  it 'should not play game without both players' do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client('Player 2')

    client1.provide_input('Ready!')

    @server.create_game_if_possible

    @server.run_game(@server.games.first)

    # handles ties
    expect(@server.games.first.rounds).to eql(0)
  end

  it 'plays multiple rounds' do
    client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    client2 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client2)
    @server.accept_new_client('Player 2')

    client1.provide_input('Ready!')
    client2.provide_input('Ready!')

    @server.create_game_if_possible

    @server.run_game(@server.games.first)

    expect(client1.capture_output).to match(/of/i)
    expect(client2.capture_output).to match(/of/i)

    # handles ties
    expect(@server.games.first.rounds).to_not eql(0)

    client1.provide_input('Ready!')
    client2.provide_input('Ready!')

    @server.run_game(@server.games.first)

    expect(client1.capture_output).to match(/of/i)
    expect(client2.capture_output).to match(/of/i)

    # handles ties
    expect(@server.games.first.rounds).to_not eql(1)
  end

  # Add more tests to make sure the game is being played
  # For example:
  #   make sure the mock client gets appropriate output
  #   make sure the next round isn't played until both clients say they are ready to play
  #   ...
end
