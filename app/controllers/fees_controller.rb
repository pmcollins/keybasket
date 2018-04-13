class FeesController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def create
    @rental_agreement.fees.create(params[:fee])
    redirect_to m([@company, @property, @unit])
  end

  def show
    @fee = @rental_agreement.fees.find(params[:id])
  end

end
