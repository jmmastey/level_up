class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :skill, index: true
      t.date :verified_on
      t.belongs_to :verifier, index: true

      t.timestamps
    end

    add_index :completions, [:user_id, :skill_id], unique: true
  end
end
