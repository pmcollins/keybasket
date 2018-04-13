class CreatePurchaseOrderLineItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_line_items do |t|
      t.column :purchase_order_id, :integer
      t.column :quantity, :integer
      t.column :product_code, :string
      t.column :description, :text
      t.column :measure_unit_id, :integer
      t.column :unit_price, :decimal, :precision => 8, :scale => 2
      t.column :total_price, :decimal, :precision => 8, :scale => 2
    end
  end

  def self.down
    drop_table :purchase_order_line_items
  end
end
