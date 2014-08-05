class CreateGlobalDatasources < ActiveRecord::Migration
  def change
    create_table :global_datasources do |t|
      t.string :name
      t.text :encrypted_config
      t.integer :datasource_type_id
      
      t.timestamps
    end
  end
end
