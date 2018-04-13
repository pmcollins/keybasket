class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.column :name, :string
      t.column :company_id, :integer
      t.column :created_on, :date
    end
  end

  def self.down
    drop_table :vendors
  end
end
