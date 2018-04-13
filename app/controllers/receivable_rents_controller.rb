class ReceivableRentsController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def create
    h = {
      :company_id => @company.id,
      :year => params[:receivable_rent]['when(1i)'],
      :month => params[:receivable_rent]['when(2i)']
    }
    ReceivableRent.create!(h)
    redirect_to m([@company])
  end

end
