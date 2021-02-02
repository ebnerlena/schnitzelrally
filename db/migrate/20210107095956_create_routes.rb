class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :location
      t.integer :radius
      t.string :game_state
      t.timestamp :start_time
      t.timestamp :end_time
      t.belongs_to :user, null: false, foreign_key: true
      t.references :users, null: true, foreign_key: true
      t.references :game_tasks, null: true, foreign_key: true

      t.timestamps
    end

    add_index :routes, :name,                unique: true
  end
end
