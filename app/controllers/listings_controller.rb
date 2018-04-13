class ListingsController < ApplicationController

  before_filter :manager_authorized?, :find_unit

  def edit
    @listing = @unit.listing
  end

  def show
    @listing = @unit.listing
  end

  def create
    begin
      Listing.transaction do
        listing = Listing.new(params[:listing])
        listing.unit = @unit
        listing.save!
      end
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, 'listings/new'])
    else
      flash[:notice] = 'Listing created successfully.'
      redirect_to m([@company, @property, @unit])
    end
  end

  def update
    begin
      Listing.transaction do
        listing = @unit.listing
        listing.update_attributes(params[:listing])
      end
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, listing, 'edit'])
    else
      flash[:notice] = 'Listing updated successfully.'
      redirect_to m([@company, @property, @unit])
    end
  end

  def destroy
    begin
      listing = @unit.listing
      listing.destroy
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, listing, 'edit'])
    else
      flash[:notice] = 'Listing deleted successfully.'
      redirect_to m([@company, @property, @unit])
    end
  end

end
