require File.dirname(__FILE__) + '/../test_helper'
require 'tenants_controller'

# Re-raise errors caught by the controller.
class TenantsController; def rescue_action(e) raise e end; end

class TenantsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :rental_agreements,
    :tenants, :contacts, :addresses, :phones
  )

  def setup
    @controller = TenantsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_tenant
    get :show, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_edit_tenant
    get :edit, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_delete_tenant
    before_count = Tenant.count
    delete :destroy, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    after_count = Tenant.count
    assert_equal(before_count, after_count + 1)
  end

  def test_update_tenant
    fname = 'Abcdef'
    lname = 'Rstuvwxyz'
    t = Tenant.find(1)
    put :update, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :id => 1,
      :contact => {
        :first_name => fname,
        :last_name => lname
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    t.reload
    c = t.contact
    c.reload #just in case it's cached!
    assert_equal(c.first_name, fname)
    assert_equal(c.last_name, lname)
    assert_response :redirect
  end

  def test_create_tenant
    ra = RentalAgreement.find(1)
    before_count = ra.tenants.count
    fname = 'Newguy'
    lname = 'McTestmonkey'
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :contact => {
        :first_name => fname,
        :last_name => lname
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    ra.reload
    after_count = ra.tenants.count
    assert_equal(before_count, after_count - 1)
  end

end
