require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < Test::Unit::TestCase
  fixtures :account_types, :accounts, :account_updates

  def test_get_balance_by_company_id
    acct = Account.load 'rent_income'
    assert acct
    balance = acct.get_balance_by_company_id 1
    assert balance
  end

end
