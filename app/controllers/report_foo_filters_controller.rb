class ReportFooFiltersController < ApplicationController

  before_filter :find_relation_attribute, :manager_authorized?

  def new
    @operators = Operator.find :all
  end

  def create
    table_name = self.class.name.underscore.gsub('_controller', '')
    filter = table_name.classify.constantize.new(
      params[table_name.singularize.to_sym]
    )
    filter.report_id = @report_id
    filter.relation_attribute_id = @relation_attribute_id
    filter.save
    redirect_to m([@company, @report])
  end

end
