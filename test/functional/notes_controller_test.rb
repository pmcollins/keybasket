require File.dirname(__FILE__) + '/../test_helper'

class NotesControllerTest < ActionController::TestCase

  fixtures :companies, :properties, :units, :managers, :coordinators,
    :addresses, :rental_agreements, :logins

  def test_index
    get :index, {
      :action => 'index',
      :property_id => '1',
      :controller => 'notes',
      :company_id => '1'
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1,
      :property_ids => [1]
    }
    assert_response :success
  end

end
