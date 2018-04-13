class ChecksController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def new
    @source_accounts = @rental_agreement.get_owed_accounts
    @target_accounts = Account.bulk_load(%w(
      undeposited_funds
      deposited_funds
    ))
  end

  def create
    check_params = params[:check]
    check_params[:account_id] = params[:check_transaction][:target_account_id]
    check_params[:company_id] = @company.id
    check = @rental_agreement.checks.create(check_params)
    check.check_transactions.create!(params[:check_transaction])
    redirect_to m([@company, @property, @unit, @rental_agreement])
  end

  def show
    @check = @rental_agreement.checks.find params[:id]
  end

end
