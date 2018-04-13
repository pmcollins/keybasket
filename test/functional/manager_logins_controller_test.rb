require File.dirname(__FILE__) + '/../test_helper'
require 'manager_logins_controller'

# Re-raise errors caught by the controller.
class ManagerLoginsController; def rescue_action(e) raise e end; end

class ManagerLoginsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :managers, :coordinators,
    :contacts, :addresses, :logins
  )

  def setup
    @controller = ManagerLoginsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_edit_manager_login
    get :edit, {
      :company_id => 1,
      :manager_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_response :success
  end

  def test_update_manager_login_password
    name = 'shosheleh'
    pwd = 'h3ll0d0lly'
    put :update, {
      :company_id => 1,
      :manager_id => 1,
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
    assert_equal(l.manager.id, 1)
    assert_response :redirect
  end

  def test_update_manager_login_name
    name = 'shoshelehx'
    pwd = 'h3ll0d0lly'
    put :update, {
      :company_id => 1,
      :manager_id => 1,
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
    assert_equal(l.manager.id, 1)
    assert_response :redirect
  end

end
