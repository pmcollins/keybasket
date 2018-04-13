class ManagerPurchaseOrdersController < ApplicationController

  before_filter :manager_authorized?, :find_manager

  def new
    @measure_units = MeasureUnit.find(:all, :order => 'ordering asc')
    @vendors = @company.vendors
  end

  def create
    if @manager
      po = PurchaseOrder.new(params[:purchase_order])
      po.company = @company
      po.requisitioner = @manager
      po.save!
      params[:purchase_order_line_item].values.each do |purchase_order_line_item|
        po.purchase_order_line_items.create(purchase_order_line_item)
      end
    end #FIXME notify here if mc
    redirect_to m([@company, @manager])
  end

  def show
    @purchase_order = @manager.purchase_orders.find(params[:id])
    @purchase_order_line_items = @purchase_order.purchase_order_line_items
  end

end
