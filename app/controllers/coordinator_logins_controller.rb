class CoordinatorLoginsController < ApplicationController

  before_filter :coordinator_authorized?, :find_coordinator

  def edit
    @login = @coordinator.login
  end

  def update
    @coordinator.login.update_attributes(
      params[:login]
    )
    redirect_to m([@company, @coordinator])
  end

end
