require File.dirname(__FILE__) + '/../test_helper'
require 'vendors_controller'

# Re-raise errors caught by the controller.
class VendorsController; def rescue_action(e) raise e end; end

class VendorsControllerTest < Test::Unit::TestCase
  def setup
    @controller = VendorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
