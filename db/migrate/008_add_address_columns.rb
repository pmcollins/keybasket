class AddAddressColumns < ActiveRecord::Migration
  def self.up
    add_column :companies,  :address_id, :integer
    add_column :contacts,   :address_id, :integer
    add_column :properties, :address_id, :integer
  end

  def self.down
    remove_column :companies,   :address_id
    remove_column :contacts,    :address_id
    remove_column :properties,  :address_id
  end
end
