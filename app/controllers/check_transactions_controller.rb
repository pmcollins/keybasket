class CheckTransactionsController < ApplicationController

  before_filter :manager_authorized?, :find_check

  def new
    @source_account = @check.account
    @target_accounts = Account.bulk_load(
      @check.get_target_account_candidate_names
    )
  end

  def create
    @check.check_transactions.create(params[:check_transaction])
    redirect_to m([@company, @property, @unit, @rental_agreement, @check])
  end

end
