class CreateDatasources < ActiveRecord::Migration
  def change
    create_table :datasources do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.text :config

      t.timestamps
    end
  end
end
