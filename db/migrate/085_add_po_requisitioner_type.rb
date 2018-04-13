class AddPoRequisitionerType < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :requisitioner_type, :string
  end

  def self.down
    remove_column :purchase_orders, :requisitioner_type
  end
end
