class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.column :po_number, :string
      t.column :created_at, :date
      t.column :required_by, :date
      t.column :title, :string
      t.column :notes, :text
      t.column :payment_term_id, :integer
      t.column :company_id, :integer
      t.column :vendor_id, :integer
      t.column :requisitioner_id, :integer #management coordinator id
      t.column :ship_to_address_id, :integer
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
