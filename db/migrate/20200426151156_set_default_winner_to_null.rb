class SetDefaultWinnerToNull < ActiveRecord::Migration[5.2]
  def change
    change_column_default :bet_pools, :winner, nil
  end
end
