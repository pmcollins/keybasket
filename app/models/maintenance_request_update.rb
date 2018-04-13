class MaintenanceRequestUpdate < ActiveRecord::Base

  belongs_to :maintenance_request_status
  belongs_to :maintenance_request

  def after_create
    self.maintenance_request.update_attributes(
      :maintenance_request_status_id => self.maintenance_request_status_id
    )
  end

end
