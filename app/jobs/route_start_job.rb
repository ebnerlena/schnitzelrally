class RouteStartJob < ApplicationJob
  queue_as :default

  def perform(*args)

    # html = ApplicationController.render(
    #   partial: 'chatmessages/message',
    #   locals: { message: message }
    # )

    # ActionCable.server.broadcast "server_channel_#route.game_id}", html: html
  end
end
