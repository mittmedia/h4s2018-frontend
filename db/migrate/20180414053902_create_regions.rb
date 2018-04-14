class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :lantmateriet_reference_id
      t.integer :parent_id
      t.integer :level

      t.timestamps
    end
    add_index :regions, :lantmateriet_reference_id
    add_index :regions, :level
    add_index :regions, :parent_id
  end
end
