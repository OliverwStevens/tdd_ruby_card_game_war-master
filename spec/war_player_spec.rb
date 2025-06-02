require_relative '../lib/war_player'

describe 'WarPlayer' do
  attr_writer :hand
  it 'Creates a new player with an empty hand' do
    name = "John"
    player = WarPlayer.new(name)
    expect(player.name).to eql(name)
    expect(player.hand).to be_empty
  end
end
