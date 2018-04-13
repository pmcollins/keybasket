class UnitPhonesController < ApplicationController

  before_filter :manager_authorized?, :find_unit

  def create
    begin
      @unit.phones.create!(params[:phone])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, @unit, 'unit_phones/new'])
    else
      flash[:notice] = 'New phone successfully created.'
      to_unit
    end
  end

  def edit
    @phone = @unit.phones.find(params[:id])
  end

  def update
    phone = @unit.phones.find(params[:id])
    phone.update_attributes(params[:phone])
    to_unit
  end

  def destroy
    phone = @unit.phones.find(params[:id])
    phone.destroy
    to_unit
  end

end
