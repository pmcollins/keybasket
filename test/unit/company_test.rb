require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < Test::Unit::TestCase
  fixtures :companies
  def test_purchase_orders_pending
    c = Company.find 1
    assert(c.purchase_orders_pending.empty?)
    PurchaseOrder.create(
      :company_id => 1
    )
    assert_equal(c.purchase_orders_pending.size, 1)
  end
end
