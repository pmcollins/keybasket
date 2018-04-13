require File.dirname(__FILE__) + '/../test_helper'

class PurchaseOrderApprovalTest < Test::Unit::TestCase
  fixtures :account_types, :accounts
  def test_create
    amount = 67.89
    po = PurchaseOrder.create(
      :company_id => 1,
      :title => 'hooa',
      :amount => amount
    )
    assert(po.errors.empty?)
    assert(!po.is_approved?)
    source_account = Account.find_by_name 'orders_payable'
    starting_source_account_balance = source_account.get_balance_by_company_id 1
    target_account = Account.find_by_name 'po_expenses'
    starting_target_account_balance = target_account.get_balance_by_company_id 1
    PurchaseOrderApproval.approve(
      :notes => 'some stuff',
      :management_coordinator_id => 1,
      :purchase_order => po,
      :company_id => 1
    )
    ending_source_account_balance = source_account.get_balance_by_company_id 1
    ending_target_account_balance = target_account.get_balance_by_company_id 1
    assert_equal(
      starting_source_account_balance,
      ending_source_account_balance - amount
    )
    assert_equal(
      starting_target_account_balance,
      ending_target_account_balance - amount
    )
    po.reload
    assert(po.is_approved?)
  end
end
