class CreateReportSnapshots < ActiveRecord::Migration
  def change
    create_table :report_snapshots do |t|
      t.integer :user_id
      t.integer :report_id
      t.text :report_data
      t.date :saved_on

      t.timestamps
    end
  end
end
