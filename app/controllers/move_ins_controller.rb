class MoveInsController < ApplicationController

  before_filter :manager_authorized?, :find_unit

  def create
    move_in_params = params[:move_in]
    move_in_params[:unit_id] = params[:unit_id]
    rental_agreement = MoveIn.create(move_in_params)
    redirect_to m([@company, @property, @unit, rental_agreement])
  end

end

