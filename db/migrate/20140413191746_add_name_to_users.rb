class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, limit: 100, null: false
  end
end
