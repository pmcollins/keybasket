class RentalAgreementAccountUpdatesController < ApplicationController

  before_filter :manager_authorized?, :find_rental_agreement

  def index
    @account_update_transfers = AccountUpdate.get_transfers_by_rental_agreement_id(
      @rental_agreement.id
    )
  end

end
