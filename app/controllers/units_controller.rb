class UnitsController < ApplicationController

  before_filter :manager_authorized?, :find_property

  def index
    @units = @property.units
  end

  def show
    @unit = @property.units.find(params[:id])
    @phones = @unit.phones
    @photos = @unit.unit_photos
    @floor_plan = @unit.floor_plan
    @rental_agreement = @unit.rental_agreement
    @maintenance_requests = @unit.get_open_maintenance_requests
  end

  def edit
    @unit = @property.units.find(params[:id])
    @floor_plans = @property.floor_plans
  end

  def create
    unit = Unit.create(params[:unit])
    @property.units << unit
    redirect_to m([@company, @property, 'units'])
  end

  def update
    @unit = @property.units.find(params[:id])
    @unit.update_attributes(params[:unit])
    redirect_to m([@company, @property, @unit])
  end

  def destroy
    unit = @property.units.find(params[:id])
    @property.units.destroy(unit)
    flash[:notice] = "Unit #{unit.apt} deleted successfully"
    redirect_to m([@company, @property])
  end

end
