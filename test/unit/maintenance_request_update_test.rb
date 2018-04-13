require File.dirname(__FILE__) + '/../test_helper'

class MaintenanceRequestUpdateTest < Test::Unit::TestCase
  fixtures :units, :properties, :companies, :maintenance_request_statuses
  def test_create
    mr = MaintenanceRequest.create(
      :unit_id => 1
    )
    assert(mr)
    assert(mr.errors.empty?)
    assert_equal(mr.maintenance_request_status_id, 1)
    mru = mr.maintenance_request_updates.create(
      :maintenance_request_status_id => 2
    )
    assert(mru)
    assert(mru.errors.empty?)
    mr.reload
    assert_equal(
      mr.maintenance_request_status_id,
      mru.maintenance_request_status_id
    )
  end
end
