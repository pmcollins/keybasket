class RelationAttributesController < ApplicationController

  before_filter(:find_report, :manager_authorized?)

  def new
    @relations = Relation.find :all
  end

  def create
    ra = RelationAttribute.find params[:relation_attribute][:id]
    redirect_to m([
      @company,
      @report,
      ra,
      ra.get_filter_table, 'new'
    ])
  end

end
