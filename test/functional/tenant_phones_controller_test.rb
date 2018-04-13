require File.dirname(__FILE__) + '/../test_helper'
require 'tenant_phones_controller'

# Re-raise errors caught by the controller.
class TenantPhonesController; def rescue_action(e) raise e end; end

class TenantPhonesControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :rental_agreements,
    :tenants, :contacts, :addresses, :phones
  )

  def setup
    @controller = TenantPhonesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_new_tenant_phone
    get :new, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :tenant_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_edit_tenant_phones
    get :edit, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :tenant_id => 1,
      :id => 90
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_delete_tenant_phones
    c = Tenant.find(1).contact
    before_count = c.phones.count
    delete :destroy, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :tenant_id => 1,
      :id => 90
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    c.reload
    after_count = c.phones.count
    assert(before_count, after_count - 1)
    assert_response :redirect
  end

  def test_update_tenant_phone
    number = '341-857-4323'
    tag = 'yup'
    put :update, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :tenant_id => 1,
      :id => 90,
      :phone => {
        :number => number,
        :tag => tag
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    p = Phone.find(90)
    assert_equal(p.number, number)
    assert_equal(p.tag, tag)
    assert_response :redirect
  end

  def test_create_tenant_phone
    c = Tenant.find(1).contact
    before_count = c.phones.count
    number = '431-785-3432'
    tag = 'something'
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :tenant_id => 1,
      :phone => {
        :number => number,
        :tag => tag
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    c.reload
    after_count = c.phones.count
    assert(before_count, after_count - 1)
  end

end

