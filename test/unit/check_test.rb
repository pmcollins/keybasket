require File.dirname(__FILE__) + '/../test_helper'

class CheckTest < Test::Unit::TestCase
  def test_get_target_account_candidate_names
    current_account = Account.find_by_name 'undeposited_funds'
    check = Check.new(
      :company_id => 1,
      :rental_agreement_id => 1,
      :account_id => current_account.id
    )
    assert_equal(
      check.get_target_account_candidate_names.size,
      Check.related_account_names.size - 1
    )
  end
end
