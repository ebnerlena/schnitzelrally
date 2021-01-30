class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :game_id
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
