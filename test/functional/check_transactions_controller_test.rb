require File.dirname(__FILE__) + '/../test_helper'
require 'check_transactions_controller'

# Re-raise errors caught by the controller.
class CheckTransactionsController; def rescue_action(e) raise e end; end

class CheckTransactionsControllerTest < Test::Unit::TestCase
  def setup
    @controller = CheckTransactionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
