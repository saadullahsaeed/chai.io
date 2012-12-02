class AddFiltersToReports < ActiveRecord::Migration
  def change
    add_column :reports, :filters, :text
  end
end
