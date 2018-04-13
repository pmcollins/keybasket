include ActionView::Helpers::NumberHelper

class Fee < ActiveRecord::Base

  belongs_to :rental_agreement

  def after_create
    rental_agreement = self.rental_agreement
    unit = rental_agreement.unit
    property = unit.property
    company = property.company
    source_account = Account.load('fee_income')
    target_account = Account.load('fees_receivable')
    AccountUpdate.transfer_funds(
      :transfer => self,
      :company_id => company.id,
      :property_id => property.id,
      :unit_id => unit.id,
      :rental_agreement_id => rental_agreement.id,
      :source_account_id => source_account.id,
      :target_account_id => target_account.id,
      :transfer_amount => self.amount
    )
  end

  def to_s
    number_to_currency(self.amount)
  end

end
