require File.dirname(__FILE__) + '/../test_helper'
require 'phones_controller'

# Re-raise errors caught by the controller.
class PhonesController; def rescue_action(e) raise e end; end

class PhonesControllerTest < Test::Unit::TestCase
  def setup
    @controller = PhonesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
