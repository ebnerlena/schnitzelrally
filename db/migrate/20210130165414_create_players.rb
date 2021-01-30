class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.belongs_to :user
      t.belongs_to :route, null: true
      t.references :game_tasks, null: true, foreign_key: true

      t.timestamps

    end
  end
end
