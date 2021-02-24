# frozen_string_literal: true

class AddRouteToGameTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :game_tasks, :route, null: false, foreign_key: true
  end
end
