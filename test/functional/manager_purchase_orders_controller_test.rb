require File.dirname(__FILE__) + '/../test_helper'
require 'manager_purchase_orders_controller'

# Re-raise errors caught by the controller.
class ManagerPurchaseOrdersController; def rescue_action(e) raise e end; end

class ManagerPurchaseOrdersControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :managers, :contacts, :addresses, :phones,
    :accounts, :account_types, :account_updates, :purchase_orders, :vendors
  )

  def setup
    @controller = ManagerPurchaseOrdersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_new_manager_purchase_order
    get :new, {
      :company_id => 1,
      :manager_id => 1
    }, {
      :company_id => 1,
      :login_id => 1,
      :manager_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_create_manager_purchase_order
    po_title = 'some po title'
    po_notes = 'some po notes'
    before_count = PurchaseOrder.count
    post :create, {
      :company_id => 1,
      :manager_id => 1,
      :purchase_order_line_item => {
        '0' => {
          :product_code => '',
          :quantity => '',
          :description => '',
          :unit_price => '',
          :measure_unit_id => '1'
        },
        '1' => {
          :product_code => '',
          :quantity => '',
          :description => '',
          :unit_price => '',
          :measure_unit_id => '1'
        }
      },
      :purchase_order => {
        :vendor_id => '1',
        :title => po_title,
        :notes => po_notes,
        :amount => '234.56',
        'required_by(1i)' => '2007',
        'required_by(2i)' => '12',
        'required_by(3i)' => '23'
      }
    }, {
      :company_id => 1,
      :login_id => 1,
      :manager_id => 1,
      :property_ids => [1]
    }
    after_count = PurchaseOrder.count
    assert_equal(before_count, after_count - 1)
    assert_response :redirect
  end

end
