class VendorsController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def show
    @vendor = @company.vendors.find(params[:id])
    @purchase_orders = @vendor.purchase_orders
  end

  def create
    @company.vendors.create(params[:vendor])
    redirect_to m([@company, 'account_types'])
  end

  def update
    vendor = @company.vendors.find(params[:id])
    vendor.update_attributes(params[:vendor])
    redirect_to m([@company])
  end

  def edit
    @vendor = @company.vendors.find(params[:id])
  end

  def destroy
    @company.vendors.find(params[:id]).destroy
    redirect_to m([@company])
  end

end
