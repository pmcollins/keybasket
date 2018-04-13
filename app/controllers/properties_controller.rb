class PropertiesController < ApplicationController

  #XXX FIXME don't let managers create properties
  before_filter :manager_authorized?, :find_company

  def show
    @property = @company.properties.find(params[:id])
    @manager_properties = @property.manager_properties
    @units = @property.units
    @maintenance_requests = @property.get_open_maintenance_requests
    @property_vendors = @property.property_vendors
    @notes = @property.notes
    @reports = @company.reports #FIXME
  end

  def edit
    @property = @company.properties.find(params[:id])
    @address = @property.address || @property.build_address
  end

  def create
    begin
      Property.transaction do
        property = Property.new(params[:property])
        address  = Address.new(params[:address])
        property.address = address
        property.save!
        address.save!
        @company.properties << property
      end
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, 'properties/new'])
    else
      flash[:notice] = 'Property was successfully created.'
      redirect_to m([@company])
    end
  end

  def update
    begin
      property = @company.properties.find(params[:id])
      Property.transaction do
        property.update_attributes(params[:property])
        if property.address
          address = property.address
          address.update_attributes(params[:address])
          address.save!
        else
          address = Address.new(params[:address])
          address.save!
          property.address = address
        end
        property.save!
      end
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, property, 'edit'])
    else
      flash[:notice] = 'Property was successfully updated.'
      redirect_to m([@company, property])
    end
  end

  def destroy
    begin
      @company.properties.find(params[:id]).destroy
    rescue Exception => e
      flash[:notice] = 'Property could not be deleted.'
      redirect_to m([@company, property])
    else
      flash[:notice] = 'Property was successfully deleted.'
      redirect_to m([@company])
    end
  end

end
