require File.dirname(__FILE__) + '/../test_helper'
require 'companies_controller'

# Re-raise errors caught by the controller.
class CompaniesController; def rescue_action(e) raise e end; end

class CompaniesControllerTest < Test::Unit::TestCase

  fixtures :companies, :properties, :units, :managers,
    :coordinators, :addresses, :contacts

  def setup
    @controller = CompaniesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @session = {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
  end

  def test_not_logged_in
    get :show, :id => 1
    assert_redirected_to '/'
  end

  def test_wrong_company_access
    get :show, {
      :id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 2
    }
    assert_redirected_to '/'
  end

  def test_manager_company_access
    get :show, {
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1
    }
    assert_response :success
  end

  def test_unauthorized_company_access
    get :update, {
      :id => 1
    }, {
      :login_id => 1,
      :manager_id => 1,
      :company_id => 1
    }
    assert_redirected_to '/'
  end

  def test_show
    get :show, {
      :id => 1
    }, @session
    assert_response :success
  end

  def test_should_get_edit
    get :edit, {
      :id => 1
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_response :success
  end

  def test_should_update_company
    put :update, {
      :id => 1,
      :company => {
        :name => 'Chicken'
      },
      :address => {
        :line1 => '123 4th Street',
        :city => 'Montevideo',
        :state => 'AK',
        :zip => '12345'
      }
    }, {
      :login_id => 1,
      :coordinator_id => 1,
      :company_id => 1
    }
    assert_redirected_to "/companies/1"
  end

  #def test_should_destroy_company
  #  old_count = Company.count
  #  delete :destroy, :id => 1
  #  assert_equal old_count-1, Company.count
  #  
  #  assert_redirected_to companies_path
  #end

  #def test_should_create_company
  #  old_count = Company.count
  #  post :create, :company => { :name => 'Acme' }
  #  assert_equal old_count+1, Company.count
  #  assert_redirected_to company_path(assigns(:company))
  #end

 
end
