class AddSortToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :sort_order, :integer
  end
end
