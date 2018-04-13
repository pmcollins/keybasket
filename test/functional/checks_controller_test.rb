require File.dirname(__FILE__) + '/../test_helper'
require 'checks_controller'

# Re-raise errors caught by the controller.
class ChecksController; def rescue_action(e) raise e end; end

class ChecksControllerTest < Test::Unit::TestCase
  def setup
    @controller = ChecksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
