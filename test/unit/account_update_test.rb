require File.dirname(__FILE__) + '/../test_helper'

class AccountUpdateTest < Test::Unit::TestCase
  fixtures :account_types, :accounts, :account_updates, :account_transfers

  def test_transfer_funds
    source_account = Account.find_by_name 'rent_income'
    assert source_account
    target_account = Account.find_by_name 'rents_receivable'
    assert target_account
    transfer_amount = 123.45
    source_starting_balance = source_account.get_balance_by_company_id 1
    target_starting_balance = target_account.get_balance_by_company_id 1
    AccountUpdate.transfer_funds(
      :transfer => nil,
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :vendor_id => 1,
      :source_account_id => source_account.id,
      :target_account_id => target_account.id,
      :transfer_amount => transfer_amount
    )
    source_ending_balance = source_account.get_balance_by_company_id 1
    assert_not_equal(source_starting_balance, source_ending_balance)
    assert_equal(source_starting_balance + transfer_amount, source_ending_balance)

    target_ending_balance = target_account.get_balance_by_company_id 1
    assert_not_equal(target_starting_balance, target_ending_balance)
    assert_equal(target_starting_balance + transfer_amount, target_ending_balance)
  end

end
