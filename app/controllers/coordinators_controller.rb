class CoordinatorsController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def show
    @coordinator = @company.coordinators.find(params[:id])
    @login = @coordinator.login
    @contact = @coordinator.contact
    @phones = @contact.phones
  end

  def create
    contact = Contact.create(params[:contact])
    login = Login.create(params[:login])
    Coordinator.create(
      :contact_id => contact.id,
      :login_id => login.id,
      :company_id => @company.id
    )
    redirect_to m([@company])
  end

end
