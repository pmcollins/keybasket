class CurrentRentsController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def create
    cr = CurrentRent.new(params[:current_rent])
    cr.rental_agreement = @unit.rental_agreement
    cr.save
    @unit.rental_agreement.recalculate_rent_increases
    flash[:notice] = 'Rent added successfully.'
    to_rental_agreement
  end

  def index
    @current_rents = @rental_agreement.current_rents
  end

  def edit
    @current_rent = CurrentRent.find(params[:id])
  end

  def update
    current_rent = CurrentRent.find(params[:id])
    current_rent.update_attributes(params[:current_rent])
    flash[:notice] = 'Rent updated successfully.'
    to_rental_agreement
  end

  def destroy
    current_rent = CurrentRent.find(params[:id])
    current_rent.destroy
    to_rental_agreement
  end

end
