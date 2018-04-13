class ManagementAccountsController < ApplicationController

  def create
    warn params.to_yaml
    ManagementAccount.create(params[:management_account])
    redirect_to '/'
  end

end
