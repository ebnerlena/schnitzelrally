class AddTypeToGameTask < ActiveRecord::Migration[6.0]
  def change
    add_column :game_tasks, :type, :string
    add_column :game_tasks, :answers, :json
    add_column :game_tasks, :solution, :string
  end
end
