require File.dirname(__FILE__) + '/../test_helper'
require 'management_accounts_controller'

# Re-raise errors caught by the controller.
class ManagementAccountsController; def rescue_action(e) raise e end; end

class ManagementAccountsControllerTest < Test::Unit::TestCase
  def setup
    @controller = ManagementAccountsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
