class CreateUnsubscribeLinks < ActiveRecord::Migration
  def change
    create_table :unsubscribe_links do |t|
      t.references :user, null: false
      t.string :token, null: false

      t.timestamps null: false
    end
  end
end
