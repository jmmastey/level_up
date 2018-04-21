class AddEmailOptOutToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :email_opt_out, :string
  end
end
