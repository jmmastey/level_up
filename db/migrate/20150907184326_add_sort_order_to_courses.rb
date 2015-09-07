class AddSortOrderToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :sort_order, :integer, default: 99
  end
end
