# frozen_string_literal: true

class CleanDeadPlayersRoutesReferences < ActiveRecord::Migration[6.0]
  def change
    remove_reference :players, :route, null: true, foreign_key: true
    remove_reference :players, :routes, null: true, foreign_key: true
    remove_reference :routes, :players, null: true, foreign_key: true
  end
end
