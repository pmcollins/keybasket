class TenantsController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def show
    @tenant = @unit.rental_agreement.tenants.find(params[:id])
    @contact = @tenant.contact
    @phones = @contact.phones
  end

  def edit
    @tenant = @unit.rental_agreement.tenants.find(params[:id])
    @contact = @tenant.contact || @tenant.build_contact
  end

  def create
    Tenant.transaction do
      contact = Contact.new(params[:contact])
      contact.save!
      tenant = Tenant.new(params[:tenant])
      tenant.contact = contact
      tenant.rental_agreement = @unit.rental_agreement
      tenant.save!
      @tenant_id = tenant.id
      flash[:notice] = 'Tenant was successfully created.'
    end
    to_tenant
  end

  def update
    Tenant.transaction do
      @tenant = @unit.rental_agreement.tenants.find(params[:id])
      @tenant.update_attributes(params[:tenant])
      @contact = @tenant.contact || @tenant.build_contact
      @contact.update_attributes(params[:contact])
      @tenant.save!
      flash[:notice] = 'Tenant was successfully updated.'
    end
    to_tenant
  end

  def destroy
    tenant = @unit.rental_agreement.tenants.find(params[:id])
    Tenant.transaction do
      contact = tenant.contact
      phones = contact.phones
      tenant.destroy
      contact.destroy
      phones.destroy_all
    end
    redirect_to m([@company, @property, @unit, @rental_agreement])
  end

end
