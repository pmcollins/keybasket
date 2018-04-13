class CreatePurchaseOrderApprovals < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_approvals do |t|
      t.column :purchase_order_id, :integer
      t.column :management_coordinator_id, :integer
      t.column :created_at, :date
      t.column :notes, :text
    end
  end

  def self.down
    drop_table :purchase_order_approvals
  end
end
