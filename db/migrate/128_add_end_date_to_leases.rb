class AddEndDateToLeases < ActiveRecord::Migration
  def self.up
    add_column :leases, :end_date, :date
  end

  def self.down
    remove_column :leases, :end_date
  end
end
