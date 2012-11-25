class RemoveColumnDatasourceTypeFromDatasources < ActiveRecord::Migration
  def up
    remove_column :datasources, :datasource_type
  end

  def down
  end
end
