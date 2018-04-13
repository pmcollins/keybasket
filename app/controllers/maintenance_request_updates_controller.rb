class MaintenanceRequestUpdatesController < ApplicationController

  before_filter :manager_authorized?, :find_maintenance_request

  def new
    @maintenance_request_statuses = MaintenanceRequestStatus.find(:all, :order => 'ordering asc')
  end

  def create
    @maintenance_request.maintenance_request_updates.create(
      params[:maintenance_request_update]
    )
    redirect_to m([@company, @property, @unit, @maintenance_request])
  end

end
