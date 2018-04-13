require File.dirname(__FILE__) + '/../test_helper'
require 'move_outs_controller'

# Re-raise errors caught by the controller.
class MoveOutsController; def rescue_action(e) raise e end; end

class MoveOutsControllerTest < Test::Unit::TestCase

  fixtures :companies, :properties, :units, :rental_agreements

  def setup
    @controller = MoveOutsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_new_moveouts
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

  def test_create_moveouts
    u = Unit.find(1)
    before_count = u.move_outs.count
    ra = u.rental_agreement
    assert(ra)
    post :create, {
      :company_id => 1,
      :property_id => 1,
      :unit_id => 1,
      :rental_agreement_id => 1,
      :move_out => {
        'moved_out_date(1i)' => '2007',
        'moved_out_date(2i)' => '12',
        'moved_out_date(3i)' => '22',
        :notes => 'bye now!'
      }
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    u.reload
    after_count = u.move_outs.count
    assert_equal(before_count, after_count - 1)
    assert_nil(u.rental_agreement)
    assert(RentalAgreement.find(1))
    assert_response :redirect
  end

end
