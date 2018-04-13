class CoordinatorPhonesController < ApplicationController

  before_filter :coordinator_authorized?, :find_coordinator

  def create
    begin
      @coordinator.contact.phones.create!(params[:phone])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @coordinator, 'coordinator_phones/new'])
    else
      flash[:notice] = 'New phone successfully created.'
      redirect_to m([@company, @coordinator])
    end
  end

  def edit
    @phone = @coordinator.contact.phones.find(params[:id])
  end

  def update
    phone = @coordinator.contact.phones.find(params[:id])
    phone.update_attributes(params[:phone])
    redirect_to m([@company, @coordinator])
  end

  def destroy
    phone = @coordinator.contact.phones.find(params[:id])
    phone.destroy
    redirect_to m([@company, @coordinator])
  end

end
