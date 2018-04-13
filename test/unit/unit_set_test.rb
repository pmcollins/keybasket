require File.dirname(__FILE__) + '/../test_helper'

class UnitSetTest < Test::Unit::TestCase
  fixtures :units, :floor_plans
  def test_update_units
    ids = [1, 2, 3, 4]
    Unit.find(ids).each do |unit|
      unit.floor_plan_id = nil
      unit.save
    end
    us = UnitSet.new(
      :floor_plan_id => 1,
      :unit_ids => ids
    )
    us.update_units
    Unit.find(ids).each do |unit|
      unit.reload
      assert_equal(unit.floor_plan_id, 1)
    end
  end
end
