class CreatePropertyVendors < ActiveRecord::Migration
  def self.up
    create_table :property_vendors do |t|
      t.integer :property_id, :vendor_id
      t.timestamps
    end
  end

  def self.down
    drop_table :property_vendors
  end
end
