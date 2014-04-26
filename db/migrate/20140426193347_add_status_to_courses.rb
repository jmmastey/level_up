class AddStatusToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :status, :string, limit: 20, null: false, default: 'created'
  end
end
