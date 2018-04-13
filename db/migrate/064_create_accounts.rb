class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.column :name, :string, :null => false
      t.column :account_type_id, :integer, :null => :false
    end
  end

  def self.down
    drop_table :accounts
  end
end
