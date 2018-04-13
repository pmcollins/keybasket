class AddMaintenanceRequestStatusColumn < ActiveRecord::Migration
  def self.up
    add_column :maintenance_requests, :maintenance_request_status_id, :integer
  end

  def self.down
    remove_column :maintenance_requests, :maintenance_request_status_id
  end
end
