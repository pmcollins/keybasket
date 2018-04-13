require File.dirname(__FILE__) + '/../test_helper'
require 'properties_controller'

# Re-raise errors caught by the controller.
class PropertiesController; def rescue_action(e) raise e end; end

class PropertiesControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :managers, :coordinators,
    :addresses, :rental_agreements, :logins
  )

  def setup
    @controller = PropertiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_show_property
    get :show, {
      :company_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_should_edit_property
    get :edit, {
      :company_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_should_create_property
    name = 'Something'
    line1 = '123 Mystreet'
    city = 'Springfield'
    zip = '54321'
    before_count = Property.count
    post :create, {
      :company_id => 1,
      :property => {
        :name => name,
        :manager_id => 1
      },
      :address => {
        :line1 => line1,
        :line2 => '',
        :city => city,
        :state => 'CA',
        :zip => zip
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    after_count = Property.count
    assert_equal(before_count, after_count - 1)
    p = Property.find_by_name name
    assert(p)
    assert_equal(name, p.name)
    a = p.address
    assert(a)
    assert_equal(line1, a.line1)
    assert_equal(city, a.city)
    assert_equal(zip, a.zip)
  end

  def test_should_update_property
    name = 'Chicken'
    line1 = 'poop'
    city = 'caca'
    zip = '23456'
    put :update, {
      :company_id => 1,
      :id => 1,
      :property => {
        :name => name,
        :manager_id => 1
      },
      :address => {
        :line1 => line1,
        :line2 => 'bbb',
        :city => city,
        :state => 'CA',
        :zip => zip
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    p = Property.find 1
    a = p.address
    assert_equal(name, p.name)
    assert_equal(line1, a.line1)
    assert_equal(city, a.city)
    assert_equal(zip, a.zip)
    assert_redirected_to m(['companies/1/properties/1'])
  end

end
