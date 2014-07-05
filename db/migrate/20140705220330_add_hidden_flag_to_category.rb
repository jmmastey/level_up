class AddHiddenFlagToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :hidden, :boolean, default: true
  end
end
