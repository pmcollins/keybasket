class AddNotesToPropertyVendors < ActiveRecord::Migration
  def self.up
    add_column :property_vendors, :notes, :text
  end

  def self.down
    remove_column :property_vendors, :notes
  end
end
