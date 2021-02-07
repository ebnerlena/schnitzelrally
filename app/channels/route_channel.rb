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
      route = Route.where(id: data['route_id']).first
      Rails.logger.warn("route #{route.name}")
      task = route.start
      Rails.logger.warn("task #{task.id}")
      RouteChannel.broadcast_to route, route_state: route.game_state, route_id: route.id, task: task.id,
                                       task_state: task.state

    elsif data['command'] == 'arrived'

      task = GameTask.find(data['task_id'])
      route = Route.where(id: data['route_id']).first
      task.arrived
      RouteChannel.broadcast_to route, route_state: route.game_state, route_id: route.id, task: task.id,
                                       task_state: task.state

    elsif data['command'] == 'add_task'
      Rails.logger.warn('tasks update')
      tasksNr = Route.where(id: data['route_id']).first.game_tasks.size
      RouteChannel.broadcast_to route, route_state: route.game_state, route_id: route.id, tasks_nr: tasksNR,
                                       type: 'tasks_update'
    end
  end
end
