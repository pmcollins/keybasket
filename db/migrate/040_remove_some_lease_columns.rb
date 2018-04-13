class RemoveSomeLeaseColumns < ActiveRecord::Migration
  def self.up
    remove_column :leases, :deposit
  end

  def self.down
    add_column :leases, :deposit, :integer
  end
end
