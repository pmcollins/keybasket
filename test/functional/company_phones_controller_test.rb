require File.dirname(__FILE__) + '/../test_helper'
require 'company_phones_controller'

# Re-raise errors caught by the controller.
class CompanyPhonesController; def rescue_action(e) raise e end; end

class CompanyPhonesControllerTest < Test::Unit::TestCase
  def setup
    @controller = CompanyPhonesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
