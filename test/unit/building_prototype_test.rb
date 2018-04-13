require File.dirname(__FILE__) + '/../test_helper'

class BuildingPrototypeTest < Test::Unit::TestCase
  fixtures :properties
  def test_create_units
    p = Property.find :first
    assert(p)
    floors = 5
    upf = 9
    BuildingPrototype.types.each do |type|
      p.units.destroy_all
      assert(p.units.empty?)
      BuildingPrototype.new(
        :property => p,
        :floors => floors,
        :units_per_floor => upf,
        :type => type
      ).create_units
      assert(p.units.any?)
      assert_equal(p.units.size, upf * floors)
      p.units.destroy_all
    end
  end
end
