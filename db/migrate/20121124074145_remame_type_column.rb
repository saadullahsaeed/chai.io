class RemameTypeColumn < ActiveRecord::Migration
  def up
    rename_column :datasources, :type, :datasource_type
    rename_column :reports, :type, :report_type
  end

  def down
  end
end
