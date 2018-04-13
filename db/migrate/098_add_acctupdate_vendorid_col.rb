class AddAcctupdateVendoridCol < ActiveRecord::Migration
  def self.up
    add_column :account_updates, :vendor_id, :integer
  end

  def self.down
    remove_column :account_updates, :vendor_id
  end
end
