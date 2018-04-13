class Account < ActiveRecord::Base

  belongs_to :account_type
  has_many :account_updates

  has_many(
    :check_transactions_as_source,
    :class_name => CheckTransaction,
    :foreign_key => 'source_account_id'
  )

  has_many(
    :check_transactions_as_target,
    :class_name => CheckTransaction,
    :foreign_key => 'target_account_id'
  )

  has_many(
    :account_transfers_as_source,
    :class_name => AccountTransfer,
    :foreign_key => 'source_account_id'
  )

  has_many(
    :account_transfers_as_target,
    :class_name => AccountTransfer,
    :foreign_key => 'target_account_id'
  )

  def self.load(name)
    Account.find_by_name name
  end

  def self.bulk_load(names)
    names.map do |name|
      self.load(name)
    end
  end

  def to_s
    self.name.humanize
  end

  #
  ##these should be taken care of by method missing
  def get_balance_by_company_id(company_id)
    get_balance('company_id', company_id)
  end

  def get_balance_by_property_id(property_id)
    get_balance('property_id', property_id)
  end

  def get_balance_by_rental_agreement_id(rental_agreement_id)
    get_balance('rental_agreement_id', rental_agreement_id)
  end
  ##
  #

  private
  
  def get_balance(column_name, object_id)
    a = Account.find_by_sql([
      'select (sum(ifnull(credit, 0.0) - ifnull(debit, 0.0))) as net_update ' +
      'from account_updates ' +
      "where #{column_name} = :object_id " +
      'and account_id = :account_id', {
        :object_id => object_id,
        :account_id => self.id
      }
    ])
    if a
      mult = self.account_type.get_inversion_multiplier
      net_update = a.first.net_update.to_f
      net_update == 0 ? net_update : net_update * mult
    else
      0.0
    end
  end

end
