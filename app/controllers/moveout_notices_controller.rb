class MoveoutNoticesController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def new
    @moveout_notice = MoveoutNotice.new
  end

  def create
    mv_params = params[:moveout_notice]
    moveout_notice = MoveoutNotice.new(mv_params)
    moveout_notice.rental_agreement_id = @unit.rental_agreement.id
    moveout_notice.save
    redirect_to m([@company, @property, @unit])
  end

  def edit
    @moveout_notice = @unit.rental_agreement.moveout_notice
  end

  def update
    moveout_notice = @unit.rental_agreement.moveout_notice
    moveout_notice.update_attributes(params[:moveout_notice])
    redirect_to m([@company, @property, @unit])
  end

  def destroy
    @unit.rental_agreement.moveout_notice.destroy
    redirect_to m([@company, @property, @unit])
  end

end
