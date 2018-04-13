class CheckTransaction < ActiveRecord::Base

  belongs_to :check
  belongs_to(
    :source_account,
    :class_name => 'Account',
    :foreign_key => 'source_account_id'
  )
  belongs_to(
    :target_account,
    :class_name => 'Account',
    :foreign_key => 'target_account_id'
  )

  def after_create
    #TODO raise here or something, plus how bout a transaction
    check = self.check
    #XXX race condition sanity check:
    #return if check.account_id != self.source_account_id
    check.account_id = self.target_account_id
    check.save!
    rental_agreement = self.check.rental_agreement
    unit = rental_agreement.unit
    property = unit.property
    company = property.company
    AccountUpdate.transfer_funds(
      :transfer => self,
      :company_id => company.id,
      :property_id => property.id,
      :unit_id => unit.id,
      :rental_agreement_id => rental_agreement.id,
      :source_account_id => self.source_account_id,
      :target_account_id => self.target_account_id,
      :transfer_amount => self.check.amount
    )
  end

end
