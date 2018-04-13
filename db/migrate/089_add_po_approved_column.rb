class AddPoApprovedColumn < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :approved, :boolean
  end

  def self.down
    remove_column :purchase_orders, :approved
  end
end
