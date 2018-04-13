require File.dirname(__FILE__) + '/../test_helper'

class LoginTest < Test::Unit::TestCase

  @@name = 'some_user'
  @@pwd = 'p4ssw0rd'

  def test_create_and_authenticate
    login = Login.create(
      :name => @@name,
      :password => @@pwd,
      :password_confirmation => @@pwd
    )
    assert(login)
    assert(login.errors.empty?)
    assert(login.salt)
    assert(login.hashed_password)
    q = Login.find_by_name(@@name)
    assert(q)
    assert_equal(q.salt, login.salt)
    assert_equal(q.hashed_password, login.hashed_password)
    assert(Login.authenticate(@@name, @@pwd))
  end

  def test_missing_password
    login = Login.create(
      :name => @@name
    )
    assert(!login.errors.empty?)
  end

  def test_name_uniq
    login = Login.create(
      :name => @@name,
      :password => @@pwd,
      :password_confirmation => @@pwd
    )
    assert(login)
    assert(login.errors.empty?)
    login = Login.create(
      :name => @@name,
      :password => @@pwd,
      :password_confirmation => @@pwd
    )
    assert(!login.errors.empty?)
    assert_equal(Login.find_all_by_name(@@name).size, 1)
  end

end
