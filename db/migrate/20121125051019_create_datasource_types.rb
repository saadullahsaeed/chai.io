class CreateDatasourceTypes < ActiveRecord::Migration
  def change
    create_table :datasource_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
