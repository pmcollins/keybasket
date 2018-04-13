class AccountUpdate < ActiveRecord::Base

  belongs_to :account
  belongs_to :company
  belongs_to :property
  belongs_to :unit
  belongs_to :rental_agreement
  belongs_to :vendor

  belongs_to :transfer, :polymorphic => true

  def self.transfer_funds(p)
    source = self.create!(
      :transfer => p[:transfer],
      :company_id => p[:company_id],
      :property_id => p[:property_id],
      :unit_id => p[:unit_id],
      :rental_agreement_id => p[:rental_agreement_id],
      :vendor_id => p[:vendor_id],
      :account_id => p[:source_account_id],
      :debit => p[:transfer_amount]
    )
    target = self.create!(
      :transfer => p[:transfer],
      :company_id => p[:company_id],
      :property_id => p[:property_id],
      :unit_id => p[:unit_id],
      :rental_agreement_id => p[:rental_agreement_id],
      :vendor_id => p[:vendor_id],
      :account_id => p[:target_account_id],
      :credit => p[:transfer_amount]
    )
    [source, target]
  end

  def self.get_transfers_by_rental_agreement_id(rental_agreement_id)
    AccountUpdate.find(
      :all,
      :select => 'transfer_type, transfer_id',
      :conditions => ['rental_agreement_id = ?', rental_agreement_id],
      :group => 'transfer_type, transfer_id'
    )
  end

  def get_net_update
    self.credit.to_f - self.debit.to_f
  end

  #This can get expensive when called by an outer loop
  #so we allow the account to be passed in.
  def normalized_update(account)
    account ||= self.account
    mult = account.account_type.get_inversion_multiplier
    if self.has_attribute?('net_update') #group by convention
      return self.net_update.to_f * mult
    else
      return self.get_net_update * mult
    end
  end

  def to_s
    self.net_update
  end

end
