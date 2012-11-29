class AddDescriptionToReports < ActiveRecord::Migration
  def change
    add_column :reports, :description, :string
  end
end
