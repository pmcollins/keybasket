require File.dirname(__FILE__) + '/../test_helper'
require 'manager_phones_controller'

# Re-raise errors caught by the controller.
class ManagerPhonesController; def rescue_action(e) raise e end; end

class ManagerPhonesControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :managers, :contacts, :phones
  )

  def setup
    @controller = ManagerPhonesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_new_manager_phone
    get :new, {
      :company_id => 1,
      :manager_id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_response :success
  end

  def test_create_manager_phone
    number = '310-423-9874'
    tag = 'kjkljkl'
    m = Manager.find(1)
    m.contact.phones.each { |p| p.destroy }
    m.reload
    assert(m.contact.phones.empty?)
    post :create, {
      :company_id => 1,
      :manager_id => 1,
      :phone => {
        :number => number,
        :tag => tag
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_response :redirect
    m.reload
    assert(m.contact.phones)
    assert_equal(m.contact.phones.size, 1)
    p = m.contact.phones.first
    assert(p)
    assert_equal(number, p.number)
    assert_equal(tag, p.tag)
  end

  def test_update_manager_phone
    number = '321-433-5432'
    tag = 'dffgd4sdbcvx'
    m = Manager.find(1)
    assert(m.contact.phones.any?)
    phone_id = 75
    put :update, {
      :company_id => 1,
      :manager_id => 1,
      :id => phone_id,
      :phone => {
        :number => number,
        :tag => tag
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    p = Phone.find(phone_id)
    assert_equal(number, p.number)
    assert_equal(tag, p.tag)
    assert_response :redirect
  end

  def test_delete_manager_phone
    phone_id = 75
    m = Manager.find(1)
    assert_equal(m.contact.phones.size, 1)
    delete :destroy, {
      :company_id => 1,
      :manager_id => 1,
      :id => phone_id
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    m.reload
    assert(m.contact.phones.empty?)
    assert_response :redirect
  end

end
