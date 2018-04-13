require File.dirname(__FILE__) + '/../test_helper'
require 'company_check_transactions_controller'

# Re-raise errors caught by the controller.
class CompanyCheckTransactionsController; def rescue_action(e) raise e end; end

class CompanyCheckTransactionsControllerTest < Test::Unit::TestCase
  def setup
    @controller = CompanyCheckTransactionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
