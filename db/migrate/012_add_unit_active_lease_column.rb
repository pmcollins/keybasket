class AddUnitActiveLeaseColumn < ActiveRecord::Migration
  def self.up
    add_column :units, :lease_id, :integer
  end

  def self.down
    remove_column :units, :lease_id
  end
end
