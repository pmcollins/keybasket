class RentalAgreementAccountTypesController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def index
    @account_types = AccountType.get_active_types
  end

  def show
    @account_type = AccountType.find params[:id]
  end

end
