class CompanyPhonesController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def create
    begin
      @company.phones.create!(params[:phone])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, 'company_phones/new'])
    else
      flash[:notice] = 'New phone successfully created.'
      redirect_to m([@company])
    end
  end

  def edit
    @phone = @company.phones.find(params[:id])
  end

  def update
    phone = @company.phones.find(params[:id])
    phone.update_attributes(params[:phone])
    redirect_to m([@company])
  end

  def destroy
    phone = @company.phones.find(params[:id])
    phone.destroy
    redirect_to m([@company])
  end

end
