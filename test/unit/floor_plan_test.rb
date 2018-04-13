require File.dirname(__FILE__) + '/../test_helper'

class FloorPlanTest < Test::Unit::TestCase
  def test_nonnegative_nominal_rent
    fp = FloorPlan.new(
      :name => 't',
      :property_id => 1,
      :bedrooms => 1,
      :bathrooms => 1
    )
    fp.nominal_rent = -1
    assert !fp.valid?
    fp.nominal_rent = 1
    assert fp.valid?
  end
end
