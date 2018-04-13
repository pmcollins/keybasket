class RentalAgreementAccountsController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def show
    @account = Account.find params[:id]
    @account_updates = @account.account_updates.find(
      :all,
      :conditions => {:rental_agreement_id => @rental_agreement.id}
    )
  end

end
