class ManagerPropertiesController < ApplicationController

  before_filter :coordinator_authorized?, :find_manager

  def index
    @properties = @manager.properties
  end

  def show
    @manager_property = @manager.manager_properties.find(params[:id])
  end

  def new
    @properties = @company.properties - @manager.properties
  end

  def create
    @manager.manager_properties.create(
      params[:manager_property]
    )
    redirect_to m([@company, @manager])
  end

  def destroy
    mp = @manager.manager_properties.find(params[:id])
    mp.destroy
    redirect_to m([@company, @manager])
  end

end
