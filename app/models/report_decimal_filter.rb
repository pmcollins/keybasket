class ReportDecimalFilter < ActiveRecord::Base

  belongs_to :report
  belongs_to :relation_attribute

  def to_s
    relation_attribute + ' ' + predicate
  end

  def predicate
    "= #{search_value.to_s}"
  end

  def filter_from_report_set(report_set)
    key = relation_attribute.relation.name.singularize.to_sym
    meth = relation_attribute.name
    report_set.find_all do |row|
      row[key].send(meth) == search_value
    end
  end

end
