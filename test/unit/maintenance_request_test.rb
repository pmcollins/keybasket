require File.dirname(__FILE__) + '/../test_helper'

class MaintenanceRequestTest < Test::Unit::TestCase
  fixtures :units, :properties, :companies
  def test_create
    mr = MaintenanceRequest.create(
      :unit_id => 1
    )
    assert(mr)
    assert(mr.errors.empty?)
    assert_equal(mr.maintenance_request_status_id, 1)
  end
end
