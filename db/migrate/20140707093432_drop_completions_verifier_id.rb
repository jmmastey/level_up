class DropCompletionsVerifierId < ActiveRecord::Migration[4.2]
  def up
    remove_column :completions, :verifier_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
