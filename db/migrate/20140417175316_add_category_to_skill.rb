class AddCategoryToSkill < ActiveRecord::Migration[4.2]
  def change
    change_table :skills do |t|
      t.belongs_to :category
    end
  end
end
