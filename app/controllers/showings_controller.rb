class ShowingsController < ApplicationController

  before_filter :manager_authorized?, :find_listing

  def create
    showing = Showing.new(params[:showing])
    showing.listing_id = @listing.id
    showing.save
    flash[:notice] = 'Showing created successfully.'
    to_listing
  end

  def edit
    @showing = @listing.showings.find(params[:id])
  end

  def update
    showing = @listing.showings.find(params[:id])
    showing.update_attributes(params[:showing])
    to_listing
  end

  def destroy
    showing = @listing.showings.find(params[:id])
    showing.destroy
    to_listing
  end

end
