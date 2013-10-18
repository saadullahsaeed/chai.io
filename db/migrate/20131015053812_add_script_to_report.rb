class AddScriptToReport < ActiveRecord::Migration
  def change
    add_column :reports, :script, :text
  end
end
