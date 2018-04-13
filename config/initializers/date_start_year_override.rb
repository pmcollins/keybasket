module ActionView
  module Helpers
    module DateHelper
      #XXX override
      def select_year(date, options = {})
        val = date ? (date.kind_of?(Fixnum) ? date : date.year) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'year', val, options)
        else
          year_options = []
          y = date ? (date.kind_of?(Fixnum) ? (y = (date == 0) ? Date.today.year : date) : date.year) : Date.today.year

          start_year, end_year = (options[:start_year] || y-10), (options[:end_year] || y+5)
          step_val = start_year < end_year ? 1 : -1
          start_year.step(end_year, step_val) do |year|
            year_options << ((val == year) ?
              %(<option value="#{year}" selected="selected">#{year}</option>\n) :
              %(<option value="#{year}">#{year}</option>\n)
            )
          end
          select_html(options[:field_name] || 'year', year_options, options)
        end
      end
    end
  end
end
