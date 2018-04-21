class AddHiddenFlagToCategory < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :hidden, :boolean, default: true
  end
end
