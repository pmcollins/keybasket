class RemovePhones < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :phone
    remove_column :units, :phone
    remove_column :managers, :office_phone
  end

  def self.down
    add_column :contacts, :phone, :string
    add_column :units, :phone, :string
    add_column :managers, :office_phone, :string
  end
end
