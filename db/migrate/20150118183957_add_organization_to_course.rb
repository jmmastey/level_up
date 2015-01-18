class AddOrganizationToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :organization, :string, limit: 50
  end
end
