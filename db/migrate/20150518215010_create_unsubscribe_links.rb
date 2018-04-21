class CreateUnsubscribeLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :unsubscribe_links do |t|
      t.references :user, null: false
      t.string :token, null: false

      t.timestamps null: false
    end
  end
end
