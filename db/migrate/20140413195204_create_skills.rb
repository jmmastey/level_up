class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :code
      t.text :sample_solution

      t.timestamps
    end
  end
end
