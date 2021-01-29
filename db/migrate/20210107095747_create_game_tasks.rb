class CreateGameTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :game_tasks do |t|
      t.string :name
      t.string :description
      t.string :hint
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
