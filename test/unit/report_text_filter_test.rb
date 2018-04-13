require File.dirname(__FILE__) + '/../test_helper'

class ReportTextFilterTest < ActiveSupport::TestCase

  fixtures :reports, :report_boolean_filters, :relations, :relation_attributes,
    :companies, :properties, :units, :rental_agreements, :tenants

  def test_filter
    r = Report.find :first
    assert(r)
    r.filters.each { |filter| filter.destroy }
    r.reload
    assert_equal(r.filters.size, 0)
    relation = Relation.find_by_name('units')
    assert(relation)
    ra = relation.relation_attributes.find_by_name('notes')
    assert(ra)
    ReportTextFilter.create(
      :report_id => r.id,
      :relation_attribute_id => ra.id,
      :search_value => 'hardwood'
    )
    r.reload
    assert_equal(r.filters.size, 1)
    assert_equal(r.run.size, 3)
  end

end
