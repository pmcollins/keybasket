class ManagerContactsController < ApplicationController

  before_filter :manager_authorized?, :find_manager

  def edit
    @contact = @manager.contact
    @address = @contact.address
  end

  def update
    contact = @manager.contact
    contact.update_attributes(
      params[:contact]
    )
    if contact.address
      contact.address.update_attributes(params[:address])
    else
      address = Address.create(params[:address])
      contact.address = address
      contact.save
    end
    redirect_to m([@company, @manager])
  end

end
