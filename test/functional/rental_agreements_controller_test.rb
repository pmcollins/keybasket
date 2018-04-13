require File.dirname(__FILE__) + '/../test_helper'
require 'rental_agreements_controller'

# Re-raise errors caught by the controller.
class RentalAgreementsController; def rescue_action(e) raise e end; end

class RentalAgreementsControllerTest < Test::Unit::TestCase

  fixtures(
    :companies, :properties, :units, :rental_agreements, :tenants, :contacts,
    :addresses, :phones, :accounts, :account_types
  )

  def setup
    @controller = RentalAgreementsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_rental_agreement
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

  def test_edit_rental_agreement
    get :edit, {
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

  def test_update_rental_agreement
    deposit = '1234.56'
    notes = 'chicken monkey'
    post :update, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :id => 1,
      :rental_agreement => {
        :deposit => deposit,
        'move_in_date(1i)' => '2005',
        'move_in_date(2i)' => '8',
        'move_in_date(3i)' => '1',
        :notes => notes
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    ra = RentalAgreement.find 1
    assert_equal(ra.deposit.to_s, deposit.to_s)
    assert_equal(ra.notes, notes)
    assert_response :redirect
  end

end
