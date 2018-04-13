require File.dirname(__FILE__) + '/../test_helper'
require 'floor_plans_controller'

# Re-raise errors caught by the controller.
class FloorPlansController; def rescue_action(e) raise e end; end

class FloorPlansControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :floor_plans,
    :rental_agreements, :current_rents
  )

  def setup
    @controller = FloorPlansController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_floor_plan
    get :show, {
      :company_id => 1,
      :property_id => 1,
      :id => 1,
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_edit_floor_plan
    get :edit, {
      :company_id => 1,
      :property_id => 1,
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

end
