class CreateAccountTransfers < ActiveRecord::Migration
  def self.up
    create_table :account_transfers do |t|
      t.column :management_coordinator_id, :integer
      t.column :source_account_id, :integer
      t.column :target_account_id, :integer
      t.column :amount, :decimal, :precision => 8, :scale => 2
      t.column :created_at, :date
      t.column :notes, :text
    end
  end

  def self.down
    drop_table :account_transfers
  end
end
