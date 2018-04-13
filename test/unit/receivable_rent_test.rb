require File.dirname(__FILE__) + '/../test_helper'

class ReceivableRentTest < Test::Unit::TestCase
  fixtures(
    :accounts,
    :account_types,
    :companies,
    :properties,
    :units,
    :rental_agreements,
    :current_rents
  )
  def test_create
    source_account = Account.find_by_name 'rent_income'
    starting_balance = source_account.get_balance_by_company_id 1
    ReceivableRent.create(
      :company_id => 1
    )
    ending_balance = source_account.get_balance_by_company_id 1
    assert_not_equal(starting_balance, ending_balance)
  end
end
