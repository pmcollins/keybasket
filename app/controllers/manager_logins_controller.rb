class ManagerLoginsController < ApplicationController

  before_filter :manager_authorized?, :find_manager

  def edit
    @login = @manager.login
  end

  def update
    @manager.login.update_attributes(
      params[:login]
    )
    redirect_to m([@company, @manager])
  end

end
