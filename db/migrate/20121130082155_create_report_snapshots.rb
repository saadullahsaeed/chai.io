class CreateReportSnapshots < ActiveRecord::Migration
  def change
    create_table :report_snapshots do |t|
      t.int :user_id
      t.int :report_id
      t.text :report_data
      t.date :saved_on

      t.timestamps
    end
  end
end
