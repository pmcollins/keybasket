class CompaniesController < ApplicationController

  before_filter :coordinator_authorized?, :except => [:new, :show]
  before_filter :manager_authorized?, :only => [:show]

  def index
    @companies = Company.find(:all)
  end

  def show
    @company = Company.find(params[:id])
    @properties = @company.properties
    @managers = @company.managers
    @coordinators = @company.coordinators
    @address = @company.address
    @phones = @company.phones
    @reports = @company.reports
  end

  def edit
    @company = Company.find(params[:id])
    @address = @company.address || @company.build_address
  end

  def create
    Company.transaction do 
      @company = Company.new(params[:company])
      @address = Address.new(params[:address])
      @company.address = @address
      @company.save!
      @address.save!
      flash[:notice] = 'Company was successfully created.'
      redirect_to m([@company])
    end
  end

  def update
    Company.transaction do 
      @company = Company.find(params[:id])
      @company.update_attributes(params[:company])
      @address = @company.address || @company.build_address
      @address.update_attributes(params[:address])
      @company.save!
      flash[:notice] = 'Company was successfully updated.'
      redirect_to m([@company])
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to m(['companies'])
  end

end
