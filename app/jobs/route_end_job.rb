# frozen_string_literal: true

class RouteEndJob < ApplicationJob
  queue_as :default

  def perform(route)
    ActionCable.server.broadcast "route_#{route.id}", route_id: route.id, type: 'route_end'
  end
end
