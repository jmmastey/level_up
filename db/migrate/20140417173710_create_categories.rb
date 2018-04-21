class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name, limit: 200, null: false
      t.string :handle, limit: 60, null: false, unique: true, index: true

      t.timestamps
    end
  end
end
