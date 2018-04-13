module ModelClassExtensions
  def searchable_columns
    columns.reject do |column|
      column.name =~ /(\b|_)id$/
    end + virtual_columns
  end
  def get_searchable_column_type_of(column_name)
    searchable_column_name_index[column_name].type
  end
  def searchable_column_name_index
    @searchable_column_name_index ||= searchable_columns.index_by(&:name)
  end
  def joinable_select_clause
    column_names.map do |column_name|
      "#{table_name}.#{column_name} AS #{table_name}_#{column_name}"
    end.join(', ')
  end
  def virtual_column(h)
    @virtual_columns ||= []
    @virtual_columns.push(VirtualColumn.new(h))
  end
  def virtual_columns
    @virtual_columns || []
  end
end
