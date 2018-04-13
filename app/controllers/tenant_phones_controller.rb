class TenantPhonesController < ApplicationController

  before_filter :manager_authorized?, :find_tenant

  def create
    begin
      @tenant.contact.phones.create!(params[:phone])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, @unit, @rental_agreement, @tenant, 'tenant_phones/new'])
    else
      flash[:notice] = 'New phone successfully created.'
      redirect_to m([@company, @property, @unit, @rental_agreement, @tenant])
    end
  end

  def edit
    @phone = @tenant.contact.phones.find(params[:id])
  end

  def update
    phone = @tenant.contact.phones.find(params[:id])
    phone.update_attributes(params[:phone])
    redirect_to m([@company, @property, @unit, @rental_agreement, @tenant])
  end

  def destroy
    phone = @tenant.contact.phones.find(params[:id])
    phone.destroy
    redirect_to m([@company, @property, @unit, @rental_agreement, @tenant])
  end

end
