class AddSortOrderToCourses < ActiveRecord::Migration[4.2]
  def change
    add_column :courses, :sort_order, :integer, default: 99
  end
end
