class ReportDateFilter < ActiveRecord::Base

  belongs_to :report
  belongs_to :relation_attribute
  belongs_to :operator

  def to_s
    relation_attribute + ' ' + predicate
  end

  def predicate
    "is #{operator.description} " + self.send("to_s_when_#{search_type}")
  end

  def to_s_when_relative
    if operator.is_between?
      return "#{days_ago1} days ago and #{days_ago2} days ago"
    else
      return "#{days_ago1} days ago"
    end
  end

  def to_s_when_absolute
    if operator.is_between?
      return "#{date1.to_s(:short)} and #{date2.to_s(:short)}"
    else
      return date1.to_s(:short)
    end
  end

  def start_date
    search_type == 'absolute' ? date1 : days_ago1.days.ago
  end

  def end_date
    search_type == 'absolute' ? date2 : days_ago2.days.ago
  end

  def filter_from_report_set(report_set)
    args = [operator.method_name, start_date]
    args.push(end_date) if operator.is_between?
    key = relation_attribute.relation.name.singularize.to_sym
    meth = relation_attribute.name
    report_set.find_all do |row|
      row[key].send(meth).send(*args)
    end
  end

end
