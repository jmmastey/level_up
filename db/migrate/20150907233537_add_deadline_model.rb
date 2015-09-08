class AddDeadlineModel < ActiveRecord::Migration
  def change
    create_table(:deadlines) do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false

      t.date :target_completed_on
      t.date :completed_on
      t.datetime :reminder_sent_at

      t.timestamps
    end

    add_column :users, :deadline_mode, :string, null: true
  end
end
