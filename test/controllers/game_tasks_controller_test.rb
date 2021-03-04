# frozen_string_literal: true

require 'test_helper'

class GameTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_task = game_tasks(:one)
    @route = routes(:one)
    @player = players(:one)
  end

  test 'should destroy game_task' do
    assert_difference('GameTask.count', -1) do
      delete route_game_task_url(@route, @game_task)
    end

    assert_redirected_to route_path(@route)
  end
end
