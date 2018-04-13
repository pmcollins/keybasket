class AccountsController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def index
    @account_types = AccountType.get_active_types
    @accounts = Account.find :all
  end

  def show
    @account = Account.find(params[:id])
    @balance = @account.get_balance_by_company_id(@company.id)
    h = {
      :conditions => {
        :company_id => @company.id
      }
    }
    if params[:group]
      h[:group] = params[:group]
      h[:select] = "#{params[:group]}, company_id, property_id, unit_id, (sum(ifnull(credit, 0.0) - ifnull(debit, 0.0))) as net_update" #FIXME only put object parent columns here
    end
    @account_updates = @account.account_updates.find(:all, h)
  end

end
