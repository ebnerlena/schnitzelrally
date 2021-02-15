class AddStateToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :state, :string
  end
end
