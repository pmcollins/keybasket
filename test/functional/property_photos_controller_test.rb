require File.dirname(__FILE__) + '/../test_helper'
require 'property_photos_controller'

# Re-raise errors caught by the controller.
class PropertyPhotosController; def rescue_action(e) raise e end; end

class PropertyPhotosControllerTest < Test::Unit::TestCase
  def setup
    @controller = PropertyPhotosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
