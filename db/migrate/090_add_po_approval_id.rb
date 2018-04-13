class AddPoApprovalId < ActiveRecord::Migration
  def self.up
    remove_column :purchase_orders,           :po_number
    remove_column :purchase_order_approvals,  :purchase_order_id
    add_column    :purchase_orders,           :purchase_order_approval_id, :string, :unique => true
  end

  def self.down
    remove_column :purchase_orders,           :purchase_order_approval_id
    add_column    :purchase_order_approvals,  :purchase_order_id, :integer
    add_column    :purchase_orders,           :po_number, :string
  end
end
