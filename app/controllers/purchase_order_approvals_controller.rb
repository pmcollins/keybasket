class PurchaseOrderApprovalsController < ApplicationController

  before_filter :coordinator_authorized?, :find_purchase_order

  def create
    unless @purchase_order.purchase_order_approval
      poa_params = params[:purchase_order_approval]
      PurchaseOrderApproval.approve(
        :notes => poa_params[:notes],
        :coordinator_id => session[:coordinator_id],
        :company_id => @company.id,
        :purchase_order => @purchase_order
      )
    end
    redirect_to m([@company])
  end

end
