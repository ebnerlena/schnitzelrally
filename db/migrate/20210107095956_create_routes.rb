class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :game_id
      t.references :game_tasks, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :users, null: true, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :location
      t.integer :radius
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
