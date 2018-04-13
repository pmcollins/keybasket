class PropertyMaintenanceRequestsController < ApplicationController

  before_filter :manager_authorized?, :find_property

  def show
    @property_maintenance_request = @property.maintenance_requests.find(
      params[:id]
    )
    @property_maintenance_request_updates = @property_maintenance_request.maintenance_request_updates
  end

  def index
    @property_maintenance_requests = @property.maintenance_requests
  end

  def create
    pmr = @property.maintenance_requests.create(params[:maintenance_request])
    redirect_to m([@company, @property, 'property_maintenance_requests', pmr.id])
  end

end
