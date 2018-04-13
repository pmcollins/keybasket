class CreateCheckTransactions < ActiveRecord::Migration
  def self.up
    create_table :check_transactions do |t|
      t.column :check_id, :integer
      t.column :created_on, :date
      t.column :notes, :text
      t.column :source_account_id, :integer
      t.column :target_account_id, :integer
    end
  end

  def self.down
    drop_table :check_transactions
  end
end
