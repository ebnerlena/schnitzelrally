class AddPlayerToRoute < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :player, null: true, foreign_key: true
  end
end
