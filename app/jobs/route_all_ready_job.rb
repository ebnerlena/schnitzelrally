class RouteAllReadyJob < ApplicationJob
  queue_as :default

  def perform(route)
    ActionCable.server.broadcast "route_#{route.id}", route_id: route.id, type: 'all_ready'
  end
end
