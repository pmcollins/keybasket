require File.dirname(__FILE__) + '/../test_helper'

class ReportBooleanFilterTest < ActiveSupport::TestCase

  fixtures :reports, :report_boolean_filters, :relations, :relation_attributes,
    :companies, :properties, :units, :rental_agreements, :tenants

  def test_filter
    rbf = ReportBooleanFilter.find :first
    rbf.update_attributes(:report_id => 0) #disassociate first
    r = Report.find :first
    assert_equal(r.filters.size, 0)
    total_count = r.run.size
    rbf.update_attributes(:report_id => r.id, :search_value => false)
    r.reload
    assert_equal(r.filters.size, 1)
    false_count = r.run.size
    rbf.update_attributes(:search_value => true)
    r.reload
    true_count = r.run.size
    assert_equal(total_count, false_count + true_count)
  end

end
