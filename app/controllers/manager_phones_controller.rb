class ManagerPhonesController < ApplicationController

  before_filter :manager_authorized?, :find_manager

  def create
    begin
      @manager.contact.phones.create(params[:phone])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @manager, 'manager_phones/new'])
    else
      flash[:notice] = 'New phone successfully created.'
      redirect_to m([@company, @manager])
    end
  end

  def edit
    @phone = @manager.contact.phones.find(params[:id])
  end

  def update
    phone = @manager.contact.phones.find(params[:id])
    phone.update_attributes(params[:phone])
    redirect_to m([@company, @manager])
  end

  def destroy
    phone = @manager.contact.phones.find(params[:id])
    phone.destroy
    redirect_to m([@company, @manager])
  end

end
