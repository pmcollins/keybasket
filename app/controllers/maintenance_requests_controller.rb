class MaintenanceRequestsController < ApplicationController

  before_filter :manager_authorized?, :find_unit

  def show
    @maintenance_request = @unit.maintenance_requests.find(params[:id])
    @maintenance_request_updates = @maintenance_request.maintenance_request_updates
  end

  def create
    mr = @unit.maintenance_requests.create(params[:maintenance_request])
    redirect_to m([@company, @property, @unit, mr])
  end

end
