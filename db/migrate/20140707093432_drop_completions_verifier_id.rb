class DropCompletionsVerifierId < ActiveRecord::Migration
  def up
    remove_column :completions, :verifier_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
