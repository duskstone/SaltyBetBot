class CreateBetPoolsColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :bet_pools, :winner, :boolean, default: false
  end
end
