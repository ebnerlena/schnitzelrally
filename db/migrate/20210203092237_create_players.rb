# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.belongs_to :user, foreign_key: true
      t.references :game_tasks, null: true, foreign_key: true
      t.references :routes, null: true, foreign_key: true

      t.timestamps
    end
  end
end
