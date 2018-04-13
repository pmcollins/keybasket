require File.dirname(__FILE__) + '/../test_helper'

class AccountTypeTest < Test::Unit::TestCase
  def test_get_balance_by_company_id
    ar = AccountType.find_by_name 'accounts_receivable'
    balance = ar.get_balance_by_company_id(1)
    assert balance
    assert(balance > 0)
  end
end
