require File.dirname(__FILE__) + '/../test_helper'

class ReportDecimalFilterTest < ActiveSupport::TestCase

  fixtures :reports, :report_boolean_filters, :relations, :relation_attributes,
    :companies, :properties, :units, :rental_agreements, :tenants

  def test_filter
    r = Report.find :first
    assert(r)
    r.filters.each { |filter| filter.destroy }
    r.reload
    assert_equal(r.filters.size, 0)
    relation = Relation.find_by_name('rental_agreements')
    assert(relation)
    ra = relation.relation_attributes.find_by_name('deposit')
    assert(ra)
    ReportIntegerFilter.create(
      :report_id => r.id,
      :relation_attribute_id => ra.id,
      :search_value => 1730.00
    )
    r.reload
    assert_equal(1, r.filters.size)
    assert_equal(1, r.run.size)
  end

end
