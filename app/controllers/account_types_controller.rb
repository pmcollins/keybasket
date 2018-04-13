class AccountTypesController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def index
    @account_types = AccountType.get_active_types
    @vendors = @company.vendors
    @purchase_orders = @company.purchase_orders_pending
  end

end
