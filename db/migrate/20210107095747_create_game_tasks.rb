# frozen_string_literal: true

class CreateGameTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :game_tasks do |t|
      t.string :name
      t.string :description
      t.string :hint
      t.float :latitude
      t.float :longitude
      t.string :location
      t.string :state

      t.timestamps
    end
  end
end
