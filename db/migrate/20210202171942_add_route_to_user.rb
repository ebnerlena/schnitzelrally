class AddRouteToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :routes,  null: true, foreign_key: true
    add_reference :users, :route,  null: true, foreign_key: true
    add_reference :users, :game_tasks,  null: true, foreign_key: true
  end
end
