class Relation < ActiveRecord::Base

  acts_as_tree

  has_many :reports
  has_many :report_filters
  has_many :relation_attributes

  def select_all_where(conditions)
    a = ancestors
    out = []
    name.classify.constantize.find(
      :all,
      :conditions => conditions,
      :include => include_thingy
    ).each do |o|
      row = { name.singularize.to_sym => o }
      current_thing = o
      a.each do |relation|
        meth = relation.name.singularize.to_sym
        row[meth] = current_thing = current_thing.send(meth)
      end
      out.push(row)
    end
    out
  end

  def include_thingy
    a = ancestors
    out = a.last.name.singularize.to_sym
    (a.size - 2).downto 0 do |i|
      out = {a[i].name.singularize.to_sym => out}
    end
    out
  end

  def ancestor_joins
    ancestors.map do |relation|
      "JOIN #{relation.name} ON #{relation.join_condition}"
    end.join(' ')
  end

  def relation_class
    name.classify.constantize
  end

  def get_searchable_columns
    klass = relation_class
    klass.searchable_columns
  end

  def get_relation_column_type(name)
    relation_class.get_column_type(name)
  end

  def to_s
    name.singularize.deunderscore
  end

  #def relation_select
  #  name.classify.constantize.joinable_select_clause
  #end

  #def lineage
  #  ancestors.unshift(self)
  #end

  #def lineage_select
  #  lineage.map do |relation|
  #    relation.relation_select
  #  end.join(', ')
  #end

  #def lineage_from
  #  lineage.reverse.map do |relation|
  #    if relation.join_condition
  #      "JOIN #{relation.name} ON #{relation.join_condition}"
  #    else
  #      relation.name
  #    end
  #  end.join(' ')
  #end

  #def lineage_base_query
  #  "SELECT #{lineage_select} FROM #{lineage_from}"
  #end

  #def run_base_query
  #  connection.select_all(lineage_base_query)
  #end

end
