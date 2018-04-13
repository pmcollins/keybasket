require File.dirname(__FILE__) + '/../test_helper'
require 'coordinators_controller'

# Re-raise errors caught by the controller.
class CoordinatorsController; def rescue_action(e) raise e end; end

class CoordinatorsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :logins,
    :coordinators, :contacts, :addresses
  )

  def setup
    @controller = CoordinatorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_coordinator
    get :show, {
      :company_id     => 1,
      :id             => 1
    }, {
      :login_id       => 1,
      :coordinator_id => 1,
      :company_id     => 1
    }
    assert assigns(:coordinator)
    assert assigns(:contact)
    assert assigns(:login)
    assert assigns(:phones)
    c = Coordinator.find(1)
    assert_equal(assigns(:coordinator), c)
    assert_equal(assigns(:contact), c.contact)
    assert_response :success
  end

end
