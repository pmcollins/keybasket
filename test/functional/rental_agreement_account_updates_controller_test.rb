require File.dirname(__FILE__) + '/../test_helper'
require 'rental_agreement_account_updates_controller'

# Re-raise errors caught by the controller.
class RentalAgreementAccountUpdatesController; def rescue_action(e) raise e end; end

class RentalAgreementAccountUpdatesControllerTest < Test::Unit::TestCase
  def setup
    @controller = RentalAgreementAccountUpdatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
