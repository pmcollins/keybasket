class AccountType < ActiveRecord::Base

  has_many :accounts

  def self.get_active_types
    self.find_by_sql(
      'select * from account_types where id in (' +
        'select distinct account_type_id from accounts' +
      ')'
    )
  end

  def self.load(type)
    self.find(:first, :conditions => "name = '#{type}'")
  end

  def to_s
    self.name.humanize
  end

  def get_inversion_multiplier
    self.inverted? ? -1 : 1
  end

  def get_balance_by_company_id(company_id)
    sum_net_updates('company_id', company_id)
  end

  def get_balance_by_rental_agreement_id(rental_agreement_id)
    sum_net_updates('rental_agreement_id', rental_agreement_id)
  end

  def account_updates
    AccountUpdate.find_by_sql([
      'select * from account_updates where account_id in (' +
        'select account_id from accounts where account_type_id = ?' +
      ')',
      self.id
    ])
  end

  def self.get_active_types
    self.find_by_sql(
      'select * from account_types where id in (' +
        'select distinct account_type_id from accounts' +
      ') ' +
      'order by ordering'
    )
  end

  private

  def sum_net_updates(column_name, object_id)
    AccountType.find_by_sql([
      'select (sum(ifnull(credit, 0.0) - ifnull(debit, 0.0))) as net_update ' +
      'from account_updates ' +
      'join accounts on accounts.id = account_updates.account_id ' +
      'join account_types on account_types.id = accounts.account_type_id ' +
      'where account_types.name = ? ' +
      "and account_updates.#{column_name} = ? ",
      self.name, object_id
    ]).first.net_update.to_f
  end

end
