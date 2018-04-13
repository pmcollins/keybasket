require File.dirname(__FILE__) + '/../test_helper'
require 'maintenance_request_updates_controller'

# Re-raise errors caught by the controller.
class MaintenanceRequestUpdatesController; def rescue_action(e) raise e end; end

class MaintenanceRequestUpdatesControllerTest < Test::Unit::TestCase
  def setup
    @controller = MaintenanceRequestUpdatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
