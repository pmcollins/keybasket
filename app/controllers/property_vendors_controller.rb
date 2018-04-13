class PropertyVendorsController < ApplicationController

  before_filter :find_property, :manager_authorized?

  def new
    @vendors = @company.vendors - @property.vendors
  end

  def create
    @property.property_vendors.create(
      params[:property_vendor]
    )
    redirect_to m([@company, @property])
  end

  def show
    get_property
  end

  def edit
    get_property
  end

  def update
    get_property
    @property_vendor.update_attributes(
      params[:property_vendor]
    )
    redirect_to m([@company, @property])
  end

  def destroy
    get_property
    @property_vendor.destroy
    redirect_to m([@company, @property])
  end

  private
  
  def get_property
    @property_vendor = @property.property_vendors.find(
      params[:id]
    )
  end

end
