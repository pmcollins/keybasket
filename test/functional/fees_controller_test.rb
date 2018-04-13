require File.dirname(__FILE__) + '/../test_helper'
require 'fees_controller'

# Re-raise errors caught by the controller.
class FeesController; def rescue_action(e) raise e end; end

class FeesControllerTest < Test::Unit::TestCase
  def setup
    @controller = FeesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
