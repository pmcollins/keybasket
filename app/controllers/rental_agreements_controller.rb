class RentalAgreementsController < ApplicationController

  before_filter :manager_authorized?, :find_unit

  def show
    @rental_agreement = @unit.rental_agreement
    @lease = @rental_agreement.lease
    @tenants = @rental_agreement.tenants
    @moveout_notice = @rental_agreement.moveout_notice
    @current_rents = @rental_agreement.current_rents
    @accounts_receivable_balance = @rental_agreement.get_balance_by_account_type(
      AccountType.load('accounts_receivable')
    ) || 0
  end

  def create
    begin
      RentalAgreement.transaction do
        current_rent = CurrentRent.create(params[:current_rent])
        rental_agreement = RentalAgreement.new(params[:rental_agreement])
        rental_agreement.unit = @unit
        rental_agreement.save!
        current_rent.rental_agreement = rental_agreement
        current_rent.effective_date = rental_agreement.move_in_date
        current_rent.save!
        @unit.rental_agreement = rental_agreement
        @unit.save!
        @rental_agreement_id = rental_agreement.id
      end
    rescue Exception => e
      flash[:notice] = e.message
    else
      flash[:notice] = 'Rental agreement created successfully.'
    end
    to_rental_agreement
  end

  def edit
    @rental_agreement = @unit.rental_agreement
  end

  def update
    begin
      @unit.rental_agreement.update_attributes(params[:rental_agreement])
    rescue Exception => e
      flash[:notice] = 'Rental agreement update failed.'
    else
      flash[:notice] = 'Rental agreement update succeeded.'
    end
    to_rental_agreement
  end

end
