class PurchaseOrdersController < ApplicationController

  before_filter :coordinator_authorized?, :find_vendor

  def new
    @measure_units = MeasureUnit.find(:all, :order => 'ordering asc')
  end

  def show
    @purchase_order = @vendor.purchase_orders.find(params[:id])
    @purchase_order_line_items = @purchase_order.purchase_order_line_items
  end

  def create
    po = PurchaseOrder.new(params[:purchase_order])
    mc = ManagementCoordinator.find session[:coordinator_id]
    po.requisitioner = mc
    po.vendor = @vendor
    po.company = @company
    po.save
    params[:purchase_order_line_item].values.each do |purchase_order_line_item|
      po.purchase_order_line_items.create(purchase_order_line_item)
    end
    redirect_to m([@company, @vendor])
  end

end
