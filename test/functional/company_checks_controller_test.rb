require File.dirname(__FILE__) + '/../test_helper'
require 'company_checks_controller'

# Re-raise errors caught by the controller.
class CompanyChecksController; def rescue_action(e) raise e end; end

class CompanyChecksControllerTest < Test::Unit::TestCase
  def setup
    @controller = CompanyChecksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
