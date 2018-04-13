require File.dirname(__FILE__) + '/../test_helper'
require 'manager_contacts_controller'

# Re-raise errors caught by the controller.
class ManagerContactsController; def rescue_action(e) raise e end; end

class ManagerContactsControllerTest < Test::Unit::TestCase
  def setup
    @controller = ManagerContactsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_edit_manager_contact
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

  def test_update_manager_contact
    first_name = 'Qqqqqq'
    last_name = 'Zzzzzz'
    line1 = '987 6th St.'
    line2 = 'Suite 900'
    city = 'Springville'
    zip = '30214'
    state = 'AZ'
    put :update, {
      :company_id => 1,
      :manager_id => 1,
      :id => 1,
      :contact => {
        :first_name => first_name,
        :last_name => last_name
      },
      :address => {
        :line1 => line1,
        :line2 => line2,
        :city => city,
        :zip => zip,
        :state => state
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_response :redirect
    m = Manager.find(1)
    c = m.contact
    a = c.address
    assert_equal(m.company_id, 1)
    assert_equal(c.first_name, first_name)
    assert_equal(c.last_name, last_name)
    assert_equal(a.line1, line1)
    assert_equal(a.line2, line2)
    assert_equal(a.city, city)
    assert_equal(a.state, state)
    assert_equal(a.zip, zip)
  end

end
