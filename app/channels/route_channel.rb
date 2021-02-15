class RouteChannel < ApplicationCable::Channel
  def subscribed
    stream_from "route_#{route.id}"
    if current_user.present?
      Rails.logger.warn("User #{current_user} subscribed to RouteChannel #{route.id} ")
    else
      Rails.logger.warn("A guest has subscribed to RouteChannel #{route.id}")
    end
  end

  def route
    # game id
    route = Route.find(params[:route_id])
  end

  def receive(data)
    if data['command'] == 'start'
      player = Player.find(data['player_id'])
      player.route_start
      ActionCable.server.broadcast "route_#{route.id}", route_id: data['route_id'], task_id: data['task_id'],
                                                        type: 'start'
    elsif data['command'] == 'next_task'
      player = Player.find(data['player_id'])
      player.route_start
    end
  end
end
