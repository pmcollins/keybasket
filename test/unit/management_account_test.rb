require File.dirname(__FILE__) + '/../test_helper'

class ManagementAccountTest < Test::Unit::TestCase
  def test_create
    #simulate creating a new mangement company account
    params = {
      :email => 'myemail@someaddress.com',
      :password => 'p4ssw0rd',
      :password_confirmation => 'p4ssw0rd',
      :first_name => 'Myfirstname',
      :last_name => 'Mylastname',
      :company_name => 'Acme Properties'
    }
    ManagementAccount.create(params)
    user = Login.authenticate(
      params[:email],
      params[:password]
    )
    assert_not_nil(user)
    assert_equal(user.name, params[:email])

    coordinator = user.coordinator
    assert_not_nil(coordinator)

    contact = coordinator.contact
    assert_not_nil(contact)
    assert_equal(contact.first_name, params[:first_name])
    assert_equal(contact.last_name, params[:last_name])

    company = coordinator.company
    assert_not_nil(company)
    assert_equal(company.name, params[:company_name])
  end
end
