require File.dirname(__FILE__) + '/../test_helper'

class FeeTest < Test::Unit::TestCase
  fixtures :companies, :properties, :units, :rental_agreements, :accounts, :account_types
  def test_create
    source_account = Account.find_by_name 'fee_income'
    target_account = Account.find_by_name 'fees_receivable'
    starting_source_balance = source_account.get_balance_by_rental_agreement_id 1
    starting_target_balance = target_account.get_balance_by_rental_agreement_id 1
    amount = 456.78
    assert_equal(RentalAgreement.find(1).fees.size, 0)
    Fee.create(
      :rental_agreement_id => 1,
      :amount => amount
    )
    assert_equal(RentalAgreement.find(1).fees.size, 1)
    ending_source_balance = source_account.get_balance_by_rental_agreement_id 1
    assert_equal(starting_source_balance + amount, ending_source_balance)
    ending_target_balance = target_account.get_balance_by_rental_agreement_id 1
    assert_equal(starting_target_balance + amount, ending_target_balance)
  end
end
