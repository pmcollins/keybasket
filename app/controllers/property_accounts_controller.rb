class PropertyAccountsController < ApplicationController

  before_filter :manager_authorized?, :find_property

  def show
    @account = Account.find params[:id]
    @rental_agreements = []
    @property.units.each do |unit|
      @rental_agreements << unit.rental_agreement if unit.rental_agreement
    end
  end

end
