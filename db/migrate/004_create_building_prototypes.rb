class CreateBuildingPrototypes < ActiveRecord::Migration
  def self.up
    create_table :building_prototypes do |t|
      t.column :floors, :integer
      t.column :units_per_floor, :integer
      t.column :property_id, :integer
    end
  end

  def self.down
    drop_table :building_prototypes
  end
end
