class CoordinatorContactsController < ApplicationController

  before_filter :coordinator_authorized?, :find_coordinator

  def edit
    @contact = @coordinator.contact
    @address = @contact.address
  end

  def update
    c = @coordinator.contact
    c.update_attributes(params[:contact])
    if c.address
      c.address.update_attributes(params[:address])
    else
      c.create_address(params[:address])
      c.save
    end
    redirect_to m([@company, @coordinator])
  end

end
