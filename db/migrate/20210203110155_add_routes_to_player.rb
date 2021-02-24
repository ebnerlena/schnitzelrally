# frozen_string_literal: true

class AddRoutesToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :players, null: true, foreign_key: true
    add_reference :routes, :player, null: true, foreign_key: true
    add_reference :game_tasks, :player, null: true, foreign_key: true
  end
end
