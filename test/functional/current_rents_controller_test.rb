require File.dirname(__FILE__) + '/../test_helper'
require 'current_rents_controller'

# Re-raise errors caught by the controller.
class CurrentRentsController; def rescue_action(e) raise e end; end

class CurrentRentsControllerTest < Test::Unit::TestCase
  
  fixtures :companies, :properties, :units, :rental_agreements, :current_rents
  
  def setup
    @controller = CurrentRentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index_current_rents
    get :index, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_new_current_rents
    get :new, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

  def test_create_current_rent
    ra = RentalAgreement.find(1)
    before_count = ra.current_rents.count
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :current_rent => {
        :amount => '1234.56',
        'effective_date(1i)' => '2007',
        'effective_date(2i)' => '3',
        'effective_date(3i)' => '1'
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    ra.reload
    after_count = ra.current_rents.count
    assert_equal(before_count, after_count - 1)
  end

  def test_edit_current_rent
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
  
  def test_destroy_current_rent
    before_count = CurrentRent.count
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
    after_count = CurrentRent.count
    assert_equal(before_count, after_count + 1)
    assert_response :redirect
  end

  def test_update_current_rent
    rent = '6543.21'
    put :update, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :id => 1,
      :current_rent => {
        :amount => rent,
        'effective_date(1i)' => '2007',
        'effective_date(2i)' => '3',
        'effective_date(3i)' => '1'
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    cr = CurrentRent.find(1)
    assert_equal(rent.to_s, cr.amount.to_s)
    assert_response :redirect
  end

end
