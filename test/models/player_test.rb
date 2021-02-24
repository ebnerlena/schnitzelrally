require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test 'create a player' do
    user = User.create(email: 'example@x.at', password: '123456')
    assert Player.create(name: 'player1', user: user)
  end

  test 'player can access routes' do
    user = User.create(email: 'example@x.at', password: '123456')
    player = Player.create(name: 'player1', user: user)
    assert_empty player.routes
  end
end
