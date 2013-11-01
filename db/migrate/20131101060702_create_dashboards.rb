class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :title
      t.integer :template_id

      t.timestamps
    end
  end
end
