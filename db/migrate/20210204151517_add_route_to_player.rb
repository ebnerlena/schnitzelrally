# frozen_string_literal: true

class AddRouteToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_reference :players, :route, null: true, foreign_key: true
  end
end
