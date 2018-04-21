class AddDifficultyToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :difficulty, :integer
  end
end
