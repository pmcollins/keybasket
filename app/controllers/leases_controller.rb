class LeasesController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def new
  end

  def create
    Lease.transaction do
      lease = Lease.new(params[:lease])
      lease.rental_agreement_id = @rental_agreement.id
      lease.save!
      @rental_agreement.lease = lease
      @rental_agreement.save!
    end
    to_rental_agreement
  end

  def edit
    @lease = @rental_agreement.leases.find(params[:id])
  end

  def update
    lease = @rental_agreement.leases.find(params[:id])
    lease.update_attributes(params[:lease])
    to_rental_agreement
  end

end
