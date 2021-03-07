# frozen_string_literal: true

module ApplicationCable
  # application cable connection class
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_devise_user
      logger.add_tags 'ActionCable', current_user
    end

    private

    def find_devise_user
      env['warden'].user
    end
  end
end
