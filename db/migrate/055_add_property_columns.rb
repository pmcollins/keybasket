class AddPropertyColumns < ActiveRecord::Migration
  def self.up
    # street, port, garage, etc.
    add_column :properties, :parking_type, :string
    add_column :properties, :has_pool, :boolean
    add_column :properties, :ad_text, :text
  end

  def self.down
    remove_column :managers, :office_phone
  end
end
