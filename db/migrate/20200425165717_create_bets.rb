class CreateBets < ActiveRecord::Migration[5.2]
  def change
    create_table :bets do |t|
      t.integer :wager, null: false
      t.integer :user_id, null: false
      t.integer :bet_pool_id, null: false 

      t.timestamps 
    end
    add_index :bets, :user_id
    add_index :bets, :bet_pool_id
  end
end
