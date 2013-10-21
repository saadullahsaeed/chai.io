class AddStarredToReport < ActiveRecord::Migration
  def change
    add_column :reports, :starred, :boolean
  end
end
