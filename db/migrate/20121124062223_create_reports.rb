class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.string :title
      t.string :type
      t.integer :datasource_id
      t.text :config

      t.timestamps
    end
  end
end
