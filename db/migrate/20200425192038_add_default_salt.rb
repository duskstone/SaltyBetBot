class AddDefaultSalt < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :salt, :integer, default: 500
  end
end
