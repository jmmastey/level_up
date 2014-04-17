class AddCategoryToSkill < ActiveRecord::Migration
  def change
    change_table :skills do |t|
      t.belongs_to :category
    end
  end
end
