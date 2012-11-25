class AddDatasourceTypeIdToDatasource < ActiveRecord::Migration
  def change
    add_column :datasources, :datasource_type_id, :integer
  end
end
