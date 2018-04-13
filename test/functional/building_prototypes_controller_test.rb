require File.dirname(__FILE__) + '/../test_helper'
require 'building_prototypes_controller'

# Re-raise errors caught by the controller.
class BuildingPrototypesController; def rescue_action(e) raise e end; end

class BuildingPrototypesControllerTest < Test::Unit::TestCase
  def setup
    @controller = BuildingPrototypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
