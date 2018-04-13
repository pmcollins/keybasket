require File.dirname(__FILE__) + '/../test_helper'
require 'user_sessions_controller'

# Re-raise errors caught by the controller.
class UserSessionsController; def rescue_action(e) raise e end; end

class UserSessionsControllerTest < Test::Unit::TestCase

  fixtures :logins, :companies, :properties, :units, :managers, :coordinators, :addresses, :rental_agreements

  def setup
    @controller = UserSessionsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_coordinator_login
    l = Login.find_by_name 'sindy'
    post(
      :create,
      :user_session => {
        :name => l.name,
        :password => 'upiy88'
      }
    )
    assert(session[:login_id])
    assert(session[:company_id])
    assert(session[:coordinator_id])
    assert_equal l.id, session[:login_id]
    assert_equal(
      l.coordinator.id,
      session[:coordinator_id]
    )
    assert_equal(
      l.coordinator.company.id,
      session[:company_id]
    )
    assert_redirected_to :controller => 'companies'
  end

  #def test_bad_password
  #  u = Login :acme_user
  #  post :create, :user_session => {:name => u.name, :password => 'foo'}
  #  assert_redirected_to :controller => 'user_sessions'
  #  assert_nil session[:login_id]
  #end

end
