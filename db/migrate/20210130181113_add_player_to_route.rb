class AddPlayerToRoute < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :player, null: true, foreign_key: true
    add_reference :game_tasks, :player, null: true, foreign_key: true
    add_column :routes, :game_state, :string
  end
end
