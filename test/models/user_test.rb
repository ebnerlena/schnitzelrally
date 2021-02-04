require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create User' do
    args = {}
    args[:email] = 'example@x.at'
    args[:password] = '123456'
    assert User.create(args)
  end
end
