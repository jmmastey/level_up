class AddOrganizationToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :organization, :string, limit: 50
  end
end
