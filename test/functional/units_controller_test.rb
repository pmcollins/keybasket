require File.dirname(__FILE__) + '/../test_helper'
require 'units_controller'

# Re-raise errors caught by the controller.
class UnitsController; def rescue_action(e) raise e end; end

class UnitsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :rental_agreements,
    :accounts, :account_types
  )

  def setup
    @controller = UnitsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_units
    get :show, {
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

  def test_edit_units
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

  def test_update_units
    u= Unit.find 1
    u.update_attributes(
      :notes => ''
    )
    assert(u.notes.empty?)
    notes = 'xyz'
    put :update, {
      :company_id => 1,
      :property_id => 1,
      :id => 1,
      :unit => {
        :floor_plan_id => '1',
        :flagged => '0',
        :apt => '101',
        :floor => '1',
        :notes => notes
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    u.reload
    assert_equal(u.notes, notes)
    assert_response :redirect
  end

  def test_index_units
    get :index, {
      :company_id => 1,
      :property_id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

end
