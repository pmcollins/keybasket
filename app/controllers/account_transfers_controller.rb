class AccountTransfersController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def new
    @accounts = Account.find :all
  end

end
