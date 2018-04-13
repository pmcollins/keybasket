require File.dirname(__FILE__) + '/../test_helper'
require 'showings_controller'

# Re-raise errors caught by the controller.
class ShowingsController; def rescue_action(e) raise e end; end

class ShowingsControllerTest < Test::Unit::TestCase
  def setup
    @controller = ShowingsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
