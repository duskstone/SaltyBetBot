class CreateBetPools < ActiveRecord::Migration[5.2]
  def change
    create_table :bet_pools do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :description
      t.integer :total_salt, null: false

      t.timestamps
    end
    add_index :bet_pools, :user_id
    add_index :bet_pools, :title
  end
end
