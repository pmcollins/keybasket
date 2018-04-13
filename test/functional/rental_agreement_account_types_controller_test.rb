require File.dirname(__FILE__) + '/../test_helper'
require 'rental_agreement_account_types_controller'

# Re-raise errors caught by the controller.
class RentalAgreementAccountTypesController; def rescue_action(e) raise e end; end

class RentalAgreementAccountTypesControllerTest < Test::Unit::TestCase
  def setup
    @controller = RentalAgreementAccountTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
