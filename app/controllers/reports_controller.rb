class ReportsController < ApplicationController

  before_filter :find_company, :manager_authorized?

  def new
    @relations = Relation.find :all
    @operators = Operator.find :all
  end

  def index
    @reports = @company.reports
  end

  def create
    report = @company.reports.new(params[:report])
    report.owner = Login.find session[:login_id]
    report.save
    redirect_to m([@company, report])
  end

  def show
    @report = @company.reports.find(params[:id])
    @filters = @report.filters
  end

  def edit
    @report = @company.reports.find(params[:id])
    @relation_attributes = RelationAttribute.find :all
  end

  def update
    @report = @company.reports.find(params[:id])
    @report.update_attributes(params[:report])
    redirect_to m([@company, @report])
  end

  def destroy
    @report = @company.reports.find(params[:id])
    @report.destroy
    redirect_to m([@company, 'reports'])
  end

  def run
    @report = @company.reports.find(params[:id])
    @rows = @report.run
    @output_fields = @report.relation_attributes
    render :layout => false
  end

end
