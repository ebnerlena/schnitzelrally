# frozen_string_literal: true

class RouteNextTaskJob < ApplicationJob
  queue_as :default

  def perform(route, task)
    ActionCable.server.broadcast "route_#{route.id}", route_id: route.id, task_id: task.id, type: 'route_next_task'
  end
end
