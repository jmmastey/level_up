class AddOrganizationToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :organization, :string, limit: 50
  end
end
