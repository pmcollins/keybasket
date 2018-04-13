require File.dirname(__FILE__) + '/../test_helper'

class ListingTest < Test::Unit::TestCase
  def test_nonnegative_rent
    l = Listing.new(
      :listing_date => '2007-11-03',
      :unit_id => 1
    )
    l.rent = -1
    assert !l.valid?

    l.rent = 1
    assert l.valid?
  end
end
