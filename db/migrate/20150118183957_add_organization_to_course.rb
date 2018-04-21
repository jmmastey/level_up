class AddOrganizationToCourse < ActiveRecord::Migration[4.2]
  def change
    add_column :courses, :organization, :string, limit: 50
  end
end
