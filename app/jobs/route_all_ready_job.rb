class RouteAllReadyJob < ApplicationJob
  queue_as :default

  def perform(route, state)
    ActionCable.server.broadcast "route_#{route.id}", route_id: route.id, type: 'all_ready', state: state
  end
end
