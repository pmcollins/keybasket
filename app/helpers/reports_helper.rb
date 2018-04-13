module ReportsHelper

  def reports_partial_form(relation_name, column)
    render(
      :partial => "reports/form_partials/#{column.type}",
      :locals => {
        :filter_name => "#{relation_name.singularize}_#{column.name}_filter",
      }
    )
  end

  def linkify(record, field)
    if field == 'apt'
      link_to(record.send(field), m([@company, record.property, record]))
    else
      record.send(field)
    end
  end

end
