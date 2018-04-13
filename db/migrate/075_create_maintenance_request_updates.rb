class CreateMaintenanceRequestUpdates < ActiveRecord::Migration
  def self.up
    create_table :maintenance_request_updates do |t|
      t.column :created_at, :date
      t.column :notes, :text
      t.column :maintenance_request_id, :integer
      t.column :maintenance_request_status_id, :integer
    end
  end

  def self.down
    drop_table :maintenance_request_updates
  end
end
