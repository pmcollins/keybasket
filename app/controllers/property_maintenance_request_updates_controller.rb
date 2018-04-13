class PropertyMaintenanceRequestUpdatesController < ApplicationController

  before_filter :manager_authorized?, :find_property_maintenance_request

  def new
    @maintenance_request_statuses = MaintenanceRequestStatus.find(
      :all,
      :order => 'ordering asc'
    )
  end

  def create
    @property_maintenance_request.maintenance_request_updates.create(
      params[:property_maintenance_request_update]
    )
    redirect_to m([
      @company, @property,
      'property_maintenance_requests', @property_maintenance_request.id
    ])
  end

end
