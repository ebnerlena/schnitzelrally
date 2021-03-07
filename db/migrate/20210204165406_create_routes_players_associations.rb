# frozen_string_literal: true

# migration
class CreateRoutesPlayersAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :routes_players_associations do |t|
      t.belongs_to :player, null: false, foreign_key: true
      t.belongs_to :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
