require File.dirname(__FILE__) + '/../test_helper'
require 'coordinator_phones_controller'

# Re-raise errors caught by the controller.
class CoordinatorPhonesController; def rescue_action(e) raise e end; end

class CoordinatorPhonesControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :managers, :coordinators, :contacts, :phones
  )

  def setup
    @controller = CoordinatorPhonesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_new_coordinator_phone
    get :new, {
      :company_id => 1,
      :coordinator_id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_response :success
  end

  def test_create_coordinator_phone
    number = '310-423-9874'
    tag = 'kjkljkl'
    c = Coordinator.find(1)
    c.contact.phones.each { |p| p.destroy }
    c.reload
    assert(c.contact.phones.empty?)
    post :create, {
      :company_id => 1,
      :coordinator_id => 1,
      :phone => {
        :number => number,
        :tag => tag
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    c.reload
    assert(c.contact.phones)
    assert_equal(c.contact.phones.size, 1)
    p = c.contact.phones.first
    assert(p)
    assert_equal(number, p.number)
    assert_equal(tag, p.tag)
    assert_response :redirect
  end

  def test_update_coordinator_phone
    number = '321-433-5432'
    tag = 'dffgd4sdbcvx'
    c = Coordinator.find(1)
    assert(c.contact.phones.any?)
    phone_id = 8
    put :update, {
      :company_id => 1,
      :coordinator_id => 1,
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

  def test_delete_coordinator_phone
    phone_id = 8
    c = Coordinator.find(1)
    assert_equal(1, c.contact.phones.size)
    delete :destroy, {
      :company_id => 1,
      :coordinator_id => 1,
      :id => phone_id
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    c.reload
    assert(c.contact.phones.empty?)
    assert_response :redirect
  end

end
