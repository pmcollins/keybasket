require File.dirname(__FILE__) + '/../test_helper'
require 'purchase_order_approvals_controller'

# Re-raise errors caught by the controller.
class PurchaseOrderApprovalsController; def rescue_action(e) raise e end; end

class PurchaseOrderApprovalsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PurchaseOrderApprovalsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
