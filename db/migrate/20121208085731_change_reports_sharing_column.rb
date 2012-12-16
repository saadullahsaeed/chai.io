class ChangeReportsSharingColumn < ActiveRecord::Migration
  def up
    rename_column :reports, :enable_sharing, :sharing_enabled
  end

  def down
  end
end
