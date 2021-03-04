# frozen_string_literal: true

require 'test_helper'

class RoutesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @route = routes(:one)
    @player = players(:one)
    @user = users(:one)
  end

  test 'should get index' do
    get routes_url
    assert_response :success
  end

  test 'should get new' do
    get new_route_url
    assert_response :success
  end
end
