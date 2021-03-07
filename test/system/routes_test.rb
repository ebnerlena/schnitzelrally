# frozen_string_literal: true

require 'application_system_test_case'

class RoutesTest < ApplicationSystemTestCase
  setup do
    @route = routes(:one)
  end

  test 'visiting the index' do
    visit routes_url
    assert_selector 'h1', text: 'Routes'
  end

  test 'creating a Route' do
    visit routes_url
    click_on 'New Route'

    fill_in 'End time', with: @route.end_time
    fill_in 'Id', with: @route.id
    fill_in 'Latitude', with: @route.latitude
    fill_in 'Longitude', with: @route.longitude
    fill_in 'Radius', with: @route.radius
    fill_in 'Start time', with: @route.start_time
    fill_in 'Tasks', with: @route.tasks_id
    click_on 'Create Route'

    assert_text 'Route was successfully created'
    click_on 'Back'
  end

  test 'updating a Route' do
    visit routes_url
    click_on 'Edit', match: :first

    fill_in 'End time', with: @route.end_time
    fill_in 'Id', with: @route.id
    fill_in 'Latitude', with: @route.latitude
    fill_in 'Longitude', with: @route.longitude
    fill_in 'Radius', with: @route.radius
    fill_in 'Start time', with: @route.start_time
    fill_in 'Tasks', with: @route.tasks_id
    click_on 'Update Route'

    assert_text 'Route was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Route' do
    visit routes_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Route was successfully destroyed'
  end
end
