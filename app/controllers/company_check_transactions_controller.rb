class CompanyCheckTransactionsController < ApplicationController

  before_filter :coordinator_authorized?, :find_company_check

  def new
    @source_account = @company_check.account
    @target_accounts = Account.bulk_load(
      @company_check.get_target_account_candidate_names
    )
  end

  def create
    @company_check.check_transactions.create(
      params[:check_transaction]
    )
    redirect_to m([@company])
  end

end
