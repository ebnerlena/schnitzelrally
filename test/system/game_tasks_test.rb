# frozen_string_literal: true

require 'application_system_test_case'

class GameTasksTest < ApplicationSystemTestCase
  setup do
    @game_task = game_tasks(:one)
  end

  test 'visiting the index' do
    visit game_tasks_url
    assert_selector 'h1', text: 'Game Tasks'
  end

  test 'creating a Game task' do
    visit game_tasks_url
    click_on 'New Game Task'

    fill_in 'Description', with: @game_task.description
    fill_in 'Hint', with: @game_task.hint
    fill_in 'Latitude', with: @game_task.latitude
    fill_in 'Longitude', with: @game_task.longitude
    fill_in 'Name', with: @game_task.name
    click_on 'Create Game task'

    assert_text 'Game task was successfully created'
    click_on 'Back'
  end

  test 'updating a Game task' do
    visit game_tasks_url
    click_on 'Edit', match: :first

    fill_in 'Description', with: @game_task.description
    fill_in 'Hint', with: @game_task.hint
    fill_in 'Latitude', with: @game_task.latitude
    fill_in 'Longitude', with: @game_task.longitude
    fill_in 'Name', with: @game_task.name
    click_on 'Update Game task'

    assert_text 'Game task was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Game task' do
    visit game_tasks_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Game task was successfully destroyed'
  end
end
