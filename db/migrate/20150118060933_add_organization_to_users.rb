class AddOrganizationToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :organization, :string, limit: 50
  end
end
