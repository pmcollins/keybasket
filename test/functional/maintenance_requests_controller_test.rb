require File.dirname(__FILE__) + '/../test_helper'
require 'maintenance_requests_controller'

# Re-raise errors caught by the controller.
class MaintenanceRequestsController; def rescue_action(e) raise e end; end

class MaintenanceRequestsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :rental_agreements,
    :accounts, :account_types, :maintenance_requests
  )

  def setup
    @controller = MaintenanceRequestsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_maintenance_requests
    get :show, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_new_maintenance_requests
    get :new, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_create_maintenance_requests
    before_count = MaintenanceRequest.count
    name = 'chicken'
    Unit.find(1).maintenance_requests.find_all_by_description('chicken').each do |mr|
      mr.destroy
    end
    assert_nil(Unit.find(1).maintenance_requests.find_by_description(name))
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :maintenance_request => {
        :description => name
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    after_count = MaintenanceRequest.count
    mr = Unit.find(1).maintenance_requests.find_by_description(name)
    assert(mr)
    assert_equal(before_count, after_count - 1)
  end

end
