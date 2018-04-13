class InsertMaintenanceRequestStatuses < ActiveRecord::Migration
  def self.up
    ['open', 'postponed', 'in_progress', 'completed', 'closed'].each_with_index do |status, n|
      MaintenanceRequestStatus.create(
        :name => status,
        :ordering => n
      )
    end
  end

  def self.down
    MaintenanceRequestStatus.delete_all
  end
end
