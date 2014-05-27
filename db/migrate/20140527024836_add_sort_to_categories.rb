class AddSortToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sort_order, :integer
  end
end
