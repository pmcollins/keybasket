require File.dirname(__FILE__) + '/../test_helper'

class ReportDateFilterTest < ActiveSupport::TestCase

  fixtures :operators, :reports, :relations, :relation_attributes,
    :companies, :properties, :units, :rental_agreements, :tenants

  def test_equal
    search_on_movein_date(
      :operator => 'eq',
      :date => Date.new(2005, 8, 1),
      :expected_size => 2
    )
    search_on_movein_date(
      :operator => 'eq',
      :date => Date.new(2005, 8, 2),
      :expected_size => 0
    )
  end

  #def test_gt
  #  search_on_movein_date(
  #    :operator => 'gt',
  #    :date => Date.new(2007, 10, 1),
  #    :expected_size => 3
  #  )
  #  search_on_movein_date(
  #    :operator => 'gt',
  #    :date => Date.new(2008, 1, 1),
  #    :expected_size => 0
  #  )
  #end

  #def test_lt
  #  search_on_movein_date(
  #    :operator => 'lt',
  #    :date => Date.new(2003, 10, 1),
  #    :expected_size => 6
  #  )
  #  search_on_movein_date(
  #    :operator => 'lt',
  #    :date => Date.new(2000, 1, 1),
  #    :expected_size => 0
  #  )
  #end

  #def test_between
  #  search_on_movein_date(
  #    :operator => 'bt',
  #    :date => Date.new(2003, 1, 1),
  #    :end_date => Date.new(2004, 1, 1),
  #    :expected_size => 4
  #  )
  #end

  def search_on_movein_date(params)
    r = Report.find :first
    assert(r)
    r.filters.each { |filter| filter.destroy }
    r.reload
    assert_equal(r.filters.size, 0)
    op = Operator.find_by_name(params[:operator])
    relation = Relation.find_by_name('rental_agreements')
    ra = relation.relation_attributes.find_by_name('move_in_date')
    assert(ra)
    ReportDateFilter.create(
      :report_id => r.id,
      :relation_attribute_id => ra.id,
      :operator_id => op.id,
      :date1 => params[:date],
      :date2 => params[:end_date],
      :search_type => 'absolute'
    )
    r.reload
    assert_equal(r.filters.size, 1)
    assert_equal(params[:expected_size], r.run.size)
  end

end
