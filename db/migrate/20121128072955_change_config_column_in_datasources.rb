class ChangeConfigColumnInDatasources < ActiveRecord::Migration
  def up
    rename_column :datasources, :config, :encrypted_config
  end

  def down
    rename_column :datasources, :encrypted_config, :config
  end
end
