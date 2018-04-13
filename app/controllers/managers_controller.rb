class ManagersController < ApplicationController

  before_filter :coordinator_authorized?, :except => [:show]
  before_filter :manager_authorized?, :only => [:show]
  before_filter :find_company

  def new
    @manager = Manager.new
  end

  def show
    @manager = @company.managers.find(params[:id])
    @manager_properties = @manager.manager_properties
    @login = @manager.login
    @contact = @manager.contact
    @phones = @contact.phones
    @purchase_orders = @manager.purchase_orders
    @is_coordinator = session[:coordinator_id] ? true : false
  end

  def create
    a = Address.create(params[:address])
    contact = Contact.new(params[:contact])
    contact.address = a
    contact.save
    login = Login.create(params[:login])
    Manager.create(
      :contact_id => contact.id,
      :login_id => login.id,
      :company_id => @company.id
    )
    redirect_to m([@company])
  end

end
