class ReportTextFilter < ActiveRecord::Base

  belongs_to :report
  belongs_to :relation_attribute

  def to_s
    relation_attribute
  end

  def predicate
    "= #{search_value}"
  end

  def filter_from_report_set(report_set)
    key = relation_attribute.relation.name.singularize.to_sym
    meth = relation_attribute.name
    report_set.find_all do |row|
      row[key].send(meth) =~ Regexp.new(search_value)
    end
  end

end
