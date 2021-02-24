# frozen_string_literal: true

class RouteStartJob < ApplicationJob
  queue_as :default

  def perform(route, task)
    ActionCable.server.broadcast "route_#{route.id}", route_id: route.id, task_id: task.id, type: 'route_start'
  end
end
