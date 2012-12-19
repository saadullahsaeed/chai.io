class AddProjectIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :project_id, :integer
  end
end
