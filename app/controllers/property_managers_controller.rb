class PropertyManagersController < ApplicationController

  before_filter :coordinator_authorized?, :find_property

  def new
    @managers = @company.managers - @property.managers
  end

  def show
    @property_manager = @property.manager_properties.find(params[:id])
  end

  def create
    @property.manager_properties.create(params[:property_manager])
    redirect_to m([@company, @property])
  end

  def destroy
    mp = @property.manager_properties.find(params[:id])
    mp.destroy
    redirect_to m([@company, @property])
  end

end
