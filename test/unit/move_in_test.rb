require File.dirname(__FILE__) + '/../test_helper'

class MoveInTest < Test::Unit::TestCase
  fixtures :accounts, :addresses, :companies, :properties, :units
  def test_creation
    u = Unit.find 1
    u.rental_agreement_id = nil
    u.save
    assert(!u.rental_agreement)
    fname = 'Jacob'
    phone ='310-430-3372' 
    ph_tag = 'cell'
    deposit = 3456
    rent = 2345
    MoveIn.create({
      :first_name => fname,
      :last_name => 'Collins',
      :phone => phone,
      :tag => ph_tag,
      'move_in_date(1i)' => '2007',
      'move_in_date(2i)' => '11',
      'move_in_date(3i)' => '03',
      :rent => rent,
      :lease_duration => '12',
      :deposit => deposit,
      :unit_id => 1
    })
    u.reload
    assert(u)
    ra = u.rental_agreement
    assert(ra)
    assert_equal(deposit, ra.deposit)
    tenants = ra.tenants
    assert(tenants.size, 1)
    c = tenants.first.contact
    assert(c)
    assert_equal(c.first_name, fname)
    ph = c.phones.first
    assert(ph)
    assert_equal(ph.number, phone)
    assert_equal(ph.tag, ph_tag)
    lease = ra.lease
    assert(lease)
    assert_equal(lease.rent, rent)
    assert_equal(lease.end_date, Date.new(2008, 10, 31))
    cr = ra.current_rent
    assert(cr)
    assert_equal(cr.amount, rent)
  end
end
