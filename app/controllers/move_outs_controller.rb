class MoveOutsController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def create
    begin
      MoveOut.transaction do
        move_out = MoveOut.new(params[:move_out])
        move_out.unit = @unit
        move_out.rental_agreement = @rental_agreement
        move_out.save!
        @unit.rental_agreement = nil
        @unit.save!
      end
    rescue Exception => e
      flash[:notice] = e.message
    else
      flash[:notice] = 'Moveout successful.'
    end
    redirect_to m([@company, @property, @unit])
  end

end
