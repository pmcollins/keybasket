class PropertyReportsController < ApplicationController

  before_filter :find_property, :manager_authorized?

  def show
    @report = @company.reports.find(params[:id])
  end

  def run
    @report = @company.reports.find(params[:id])
    @rows = @report.run('properties.id' => @property.id)
    @output_fields = @report.relation_attributes
    render :layout => false
  end

end
