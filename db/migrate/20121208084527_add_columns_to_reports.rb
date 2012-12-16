class AddColumnsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :enable_sharing, :boolean
    add_column :reports, :sharing_config, :text
  end
end
