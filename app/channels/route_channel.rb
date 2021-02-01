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
        #Route.find(params[:route_id])
        Route.last
    end

    def receive(data)
        ActionCable.server.broadcast("route_#{params[:room]}", data)
        # new Notification(data["title"], body: data["body"])
    end
    

end
