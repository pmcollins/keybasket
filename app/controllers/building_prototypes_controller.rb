class BuildingPrototypesController < ApplicationController

  before_filter :manager_authorized?, :find_property

  def new
    @types = BuildingPrototype.types
  end

  def create
    b = BuildingPrototype.new(params[:building_prototype])
    b.property = @property
    b.create_units
    redirect_to m([@company, @property])
  end

end
