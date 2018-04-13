class CreateMaintenanceRequestStatuses < ActiveRecord::Migration
  def self.up
    create_table :maintenance_request_statuses do |t|
      t.column :name, :string
      t.column :ordering, :integer
    end
  end

  def self.down
    drop_table :maintenance_request_statuses
  end
end
