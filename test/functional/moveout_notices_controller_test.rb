require File.dirname(__FILE__) + '/../test_helper'
require 'moveout_notices_controller'

class MoveoutNoticesController; def rescue_action(e) raise e end; end

class MoveoutNoticesControllerTest < Test::Unit::TestCase

  def setup
    @controller = MoveoutNoticesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_new_moveout_notice
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

  def test_create_moveout_notice
    before_count = MoveoutNotice.count
    ra = RentalAgreement.find(1)
    mn = ra.moveout_notice
    if mn
      mn.destroy
    end
    ra.reload
    assert_nil(ra.moveout_notice)
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :moveout_notice => {
        'notice_date(3i)'  => '21',
        'moveout_date(1i)' => '2008',
        'moveout_date(2i)' => '1',
        'moveout_date(3i)' => '1',
        'notice_date(1i)'  => '2007',
        'notice_date(2i)'  => '12'
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    ra.reload
    mn = ra.moveout_notice
    assert(mn)
    after_count = MoveoutNotice.count
    assert_equal(before_count, after_count - 1)
    assert_response :redirect
  end

end
