class AddPoAmountColumn < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :amount, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :amount, :decimal
  end
end
