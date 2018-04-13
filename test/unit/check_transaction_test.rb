require File.dirname(__FILE__) + '/../test_helper'

class CheckTransactionTest < Test::Unit::TestCase
  fixtures(
    :accounts,
    :account_types,
    :companies,
    :properties,
    :units,
    :rental_agreements
  )
  def test_create
    source_account = Account.find_by_name 'undeposited_funds'
    amount = 234.56
    check = Check.create(
      :amount => amount,
      :company_id => 1,
      :rental_agreement_id => 1,
      :account_id => source_account.id
    )
    target_account = Account.find_by_name 'deposited_funds'
    starting_source_account_balance = source_account.get_balance_by_company_id 1
    starting_target_account_balance = target_account.get_balance_by_company_id 1
    CheckTransaction.create(
      :check => check,
      :source_account_id => source_account.id,
      :target_account_id => target_account.id
    )
    ending_source_account_balance = source_account.get_balance_by_company_id 1
    ending_target_account_balance = target_account.get_balance_by_company_id 1
    assert_equal(
      starting_source_account_balance,
      ending_source_account_balance + amount
    )
    assert_equal(
      starting_target_account_balance,
      ending_target_account_balance - amount
    )
  end
end
