class AddEmailOptOutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_opt_out, :string
  end
end
