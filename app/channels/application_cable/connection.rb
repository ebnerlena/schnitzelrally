# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_devise_user
      logger.add_tags 'ActionCable', current_user
    end

    private

    def find_devise_user
      env['warden'].user
      # if verified_user = User.find_by(id: cookies.encrypted[:user_id])
      #   verified_user
      # else
      #   reject_unauthorized_connection
      # end
    end
  end
end
