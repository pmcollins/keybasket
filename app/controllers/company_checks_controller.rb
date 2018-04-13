class CompanyChecksController < ApplicationController

  before_filter :coordinator_authorized?, :find_company

  def index
    @checks = @company.checks
  end

  def show
    @check = @company.checks.find params[:id]
  end

end
