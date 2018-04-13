class CreateReceivableRents < ActiveRecord::Migration
  def self.up
    create_table :receivable_rents do |t|
      t.column :company_id, :integer, :null => false
      t.column :year, :integer, :null => false
      t.column :month, :integer, :null => false
      t.column :created_on, :date
    end
  end

  def self.down
    drop_table :receivable_rents
  end
end
