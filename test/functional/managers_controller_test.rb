require File.dirname(__FILE__) + '/../test_helper'
require 'managers_controller'

# Re-raise errors caught by the controller.
class ManagersController; def rescue_action(e) raise e end; end

class ManagersControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :managers,
    :logins, :contacts, :addresses, :accounts, :account_types
  )

  def setup
    @controller = ManagersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_manager
    get :show, {
      :company_id => 1,
      :manager_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_new_manager
    get :new, {
      :company_id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_create_manager
    name = 'reeterbug'
    fname = 'Annmarie'
    lname = 'Jacobson'
    pwd = 'upiy88'
    Login.find(:all, :conditions => {:name => name}).each do |login|
      login.destroy
    end
    ic = IncrementCounter.new(
      %w(logins managers contacts addresses)
    )
    post :create, {
      :company_id => 1,
      :contact => {
        :first_name => fname,
        :last_name => lname
      },
      :address => {
        :line1 => '1234 4th Street',
        :line2 => '',
        :city => 'Chickentown',
        :zip => '12345',
        :state => 'CA'
      },
      :login => {
        :name => name,
        :password_confirmation => pwd,
        :password => pwd
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert(ic.all_incremented?)
    assert_response :redirect
    l = Login.authenticate(name, pwd)
    assert(l)
    assert(l.manager)
    assert_equal(l.manager.company_id, 1)
  end

  #editing is done piecemeal, eg. login only, etc.
  #def test_edit_manager
  #  get :edit, {
  #    :company_id => 1,
  #    :id => 1
  #  }, {
  #    :login_id => 1,
  #    :coordinator_id => 1,
  #    :company_id => 1,
  #    :property_ids => [1]
  #  }
  #  assert_response :success
  #end

  #def test_update_manager
  #  put :update, {
  #    :company_id => 1,
  #    :id => 1,
  #    :manager => {
  #    }
  #  }, {
  #    :login_id => 1,
  #    :coordinator_id => 1,
  #    :company_id => 1,
  #    :property_ids => [1]
  #  }
  #  assert_response :success
  #end

end
