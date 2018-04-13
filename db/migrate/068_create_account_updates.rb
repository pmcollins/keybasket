class CreateAccountUpdates < ActiveRecord::Migration

  def self.up
    create_table :account_updates do |t|
      t.column :transfer_id, :integer
      t.column :transfer_type, :string
      t.column :account_id, :integer, :null => false
      t.column :company_id, :integer, :null => false
      t.column :property_id, :integer
      t.column :unit_id, :integer
      t.column :rental_agreement_id, :integer
      t.column :credit, :decimal, :precision => 8, :scale => 2
      t.column :debit,  :decimal, :precision => 8, :scale => 2
      t.column :created_on, :date
    end
  end

  def self.down
    drop_table :account_updates
  end

end
