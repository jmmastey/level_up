class AddOrganizationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organization, :string, limit: 50
  end
end
