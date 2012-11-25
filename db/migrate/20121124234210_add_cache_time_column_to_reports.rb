class AddCacheTimeColumnToReports < ActiveRecord::Migration
  def change
    add_column :reports, :cache_time, :integer
  end
end
