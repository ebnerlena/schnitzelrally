# frozen_string_literal: true

# route tasks update job
class RouteTasksUpdateJob < ApplicationJob
  queue_as :default

  def perform(route)
    ActionCable.server.broadcast "route_#{route.id}", route_id: route.id, tasks_nr: route.game_tasks.size,
                                                      type: 'tasks_update'
  end
end
