class RouteChannel < ApplicationCable::Channel
  def subscribed
    stream_for route
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

      Rails.logger.warn("start command in channel #{data['route_id']}")
      route = Route.where(id: data['route_id']).first
      task = route.start
      
      RouteChannel.broadcast_to route, route_state: route.game_state, route_id: route.id,task: task.id, task_state: task.state
      #route.start

      Rails.logger.warn("after broadcasting")

    elsif data['command'] == 'arrived'

      Rails.logger.warn("arrived command in channel #{data['route_id']}")
      task = GameTask.find(data['task_id'])
      route = Route.where(id: data['route_id']).first
      task.arrived
      RouteChannel.broadcast_to route, route_state: route.game_state, route_id: route.id, task: task.id, task_state: task.state
    end

  end

end
