require File.dirname(__FILE__) + '/../test_helper'
require 'property_accounts_controller'

# Re-raise errors caught by the controller.
class PropertyAccountsController; def rescue_action(e) raise e end; end

class PropertyAccountsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PropertyAccountsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
