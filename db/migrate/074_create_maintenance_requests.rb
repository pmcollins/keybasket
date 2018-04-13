class CreateMaintenanceRequests < ActiveRecord::Migration
  def self.up
    create_table :maintenance_requests do |t|
      t.column :description, :text
      t.column :unit_id, :integer
      t.column :property_id, :integer
      t.column :created_at, :date
    end
  end

  def self.down
    drop_table :maintenance_requests
  end
end
