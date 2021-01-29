require 'test_helper'

class GameTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_task = game_tasks(:one)
  end

  test 'should get index' do
    get game_tasks_url
    assert_response :success
  end

  test 'should get new' do
    get new_game_task_url
    assert_response :success
  end

  test 'should create game_task' do
    assert_difference('GameTask.count') do
      post game_tasks_url,
           params: { game_task: { description: @game_task.description, hint: @game_task.hint, latitude: @game_task.latitude,
                                  longitude: @game_task.longitude, name: @game_task.name, user_id: @game_task.user_id, users_id: @game_task.users_id } }
    end

    assert_redirected_to game_task_url(GameTask.last)
  end

  test 'should show game_task' do
    get game_task_url(@game_task)
    assert_response :success
  end

  test 'should get edit' do
    get edit_game_task_url(@game_task)
    assert_response :success
  end

  test 'should update game_task' do
    patch game_task_url(@game_task),
          params: { game_task: { description: @game_task.description, hint: @game_task.hint, latitude: @game_task.latitude,
                                 longitude: @game_task.longitude, name: @game_task.name, user_id: @game_task.user_id, users_id: @game_task.users_id } }
    assert_redirected_to game_task_url(@game_task)
  end

  test 'should destroy game_task' do
    assert_difference('GameTask.count', -1) do
      delete game_task_url(@game_task)
    end

    assert_redirected_to game_tasks_url
  end
end
