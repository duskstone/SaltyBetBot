class CreateChanges < ActiveRecord::Migration[5.2]
  def change
    remove_column :bet_pools, :total_salt
    add_column :bets, :action, :boolean
  end
end
