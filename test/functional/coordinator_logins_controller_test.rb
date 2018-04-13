require File.dirname(__FILE__) + '/../test_helper'
require 'coordinator_logins_controller'

# Re-raise errors caught by the controller.
class CoordinatorLoginsController; def rescue_action(e) raise e end; end

class CoordinatorLoginsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :coordinators, :coordinators,
    :contacts, :addresses, :logins
  )

  def setup
    @controller = CoordinatorLoginsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_edit_coordinator_login
    get :edit, {
      :company_id => 1,
      :coordinator_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert(assigns(:login))
    assert_response :success
  end

  def test_update_coordinator_login_password
    name = 'sindy'
    pwd = 'h3ll0d0lly'
    put :update, {
      :company_id => 1,
      :coordinator_id => 1,
      :id => 1,
      :login => {
        :name => name,
        :password_confirmation => pwd,
        :password => pwd
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    l = Login.authenticate(name, pwd)
    assert(l)
    assert_equal(l.coordinator.id, 1)
    assert_response :redirect
  end

  def test_update_coordinator_login_name
    name = 'shoshelehx'
    pwd = 'ch1ck3nd0g'
    put :update, {
      :company_id => 1,
      :coordinator_id => 1,
      :id => 1,
      :login => {
        :name => name,
        :password_confirmation => pwd,
        :password => pwd
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    l = Login.authenticate(name, pwd)
    assert(l)
    assert_equal(l.coordinator.id, 1)
    assert_response :redirect
  end

end
