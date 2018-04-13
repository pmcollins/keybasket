require File.dirname(__FILE__) + '/../test_helper'
require 'purchase_order_line_items_controller'

# Re-raise errors caught by the controller.
class PurchaseOrderLineItemsController; def rescue_action(e) raise e end; end

class PurchaseOrderLineItemsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PurchaseOrderLineItemsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
