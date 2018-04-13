require File.dirname(__FILE__) + '/../test_helper'
require 'leases_controller'

# Re-raise errors caught by the controller.
class LeasesController; def rescue_action(e) raise e end; end

class LeasesControllerTest < Test::Unit::TestCase

  fixtures :companies, :properties, :units, :rental_agreements, :current_rents, :leases

  def setup
    @controller = LeasesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_edit_lease
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
  
  def test_update_lease
    rent = '2435.46'
    notes = 'some sweet, sweet notes'
    put :update, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :id => 1,
      :lease => {
        'start_date(1i)' => '2005',
        'start_date(2i)' => '8',
        'start_date(3i)' => '1',
        :notes => notes,
        :rent => rent,
        :duration_months => '12'
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    l = Lease.find(1)
    assert_equal(l.notes, notes)
    assert_equal(l.rent.to_s, rent)
  end

  def test_create_lease
    ra = RentalAgreement.find(1)
    ra.lease.destroy if ra.lease
    ra.reload
    assert_nil(ra.lease)
    rent = '2345.11'
    notes = 'yup!'
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :lease => {
        'start_date(1i)' => '2005',
        'start_date(2i)' => '8',
        'start_date(3i)' => '1',
        :notes => notes,
        :rent => rent,
        :duration_months => '12'
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :redirect
    ra.reload
    l = ra.lease
    assert_equal(l.notes, notes)
    assert_equal(l.rent.to_s, rent)
  end

end
