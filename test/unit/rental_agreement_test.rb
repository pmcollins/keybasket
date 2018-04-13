require File.dirname(__FILE__) + '/../test_helper'

class RentalAgreementTest < Test::Unit::TestCase

  fixtures :companies, :properties, :units, :rental_agreements, :current_rents

  def test_current_rent
    ra = RentalAgreement.find(1)
    assert(ra)
    ra.current_rents.each {|cr| cr.destroy}
    ra.reload
    assert(ra.current_rents.empty?)
    assert_nil(ra.current_rent)
    rent = '1234.56'
    ra.current_rents.create(
      :amount => rent,
      :effective_date => 10.days.ago.to_date
    )
    assert(ra.current_rents.any?)
    cr = ra.current_rent
    assert(cr)
    assert_equal(cr.amount.to_s, rent)
    #adding a rent with an effective date of tomorrow
    #shouldn't change the current rent
    ra.current_rents.create(
      :amount => '9876.54',
      :effective_date => Date.tomorrow
    )
    cr = ra.current_rent
    assert(cr)
    assert_equal(cr.amount.to_s, rent)
    new_rent = '4567.89'
    #adding a rent with an effective date of yesterday
    #should change the current rent
    ra.current_rents.create(
      :amount => new_rent,
      :effective_date => Date.yesterday
    )
    cr = ra.current_rent
    assert(cr)
    assert_equal(cr.amount.to_s, new_rent)
  end

  def test_recalculate_rent_increases
    ra = RentalAgreement.find(3)
    rent_history = ra.current_rents
    assert_equal(3, rent_history.size)
    rent_history.each do |cr|
      cr.update_attributes(
        :increase_amount => nil
      )
    end
    ra.recalculate_rent_increases
    ra.reload
    (1 .. rent_history.size-1).each do |i|
      old_rent = rent_history[i-1]
      new_rent = rent_history[i]
      assert(new_rent.increase_amount)
      assert_equal(old_rent.amount + new_rent.increase_amount, new_rent.amount)
    end
  end

end
