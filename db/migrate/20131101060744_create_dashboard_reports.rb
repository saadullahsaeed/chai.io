class CreateDashboardReports < ActiveRecord::Migration
  def change
    create_table :dashboard_reports do |t|
      t.integer :dashboard_id
      t.integer :report_id
      t.integer :report_index

      t.timestamps
    end
  end
end
