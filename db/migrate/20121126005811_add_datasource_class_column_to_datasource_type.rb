class AddDatasourceClassColumnToDatasourceType < ActiveRecord::Migration
  def change
    add_column :datasource_types, :datasource_class, :string
  end
end
