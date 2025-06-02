require_relative '../lib/war_player'

describe 'WarPlayer' do
  attr_writer :hand
  it 'Creates a new player with an empty hand' do
    player = WarPlayer.new("John")
    expect(player).to be_a(WarPlayer)
    expect(player.name).to eql("John")
    expect(player.hand).to eql([])
  end
end
