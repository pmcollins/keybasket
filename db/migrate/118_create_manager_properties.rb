class CreateManagerProperties < ActiveRecord::Migration
  def self.up
    create_table :manager_properties do |t|
      t.integer :manager_id, :property_id
      t.timestamps
    end
  end

  def self.down
    drop_table :manager_properties
  end
end
