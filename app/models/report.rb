class Report < ActiveRecord::Base

  belongs_to :company
  belongs_to :owner, :polymorphic => true 

  has_and_belongs_to_many :relation_attributes

  FILTERS = [
    :report_boolean_filters,
    :report_date_filters,
    :report_decimal_filters,
    :report_integer_filters,
    :report_text_filters
  ]

  FILTERS.each do |filter|
    has_many filter
  end

  def filters
    FILTERS.inject([]) do |out, filter|
      out.concat self.send(filter)
    end
  end

  def run(filter = {})
    base_filter = {'properties.company_id' => company_id}
    merged_filter = base_filter.merge(filter)
    report_set = Relation.find_by_name('rental_agreements').select_all_where(
      merged_filter
    )
    filters.each do |filter|
      report_set = filter.filter_from_report_set(report_set)
    end
    report_set
  end

end
