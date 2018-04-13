class FloorPlansController < ApplicationController

  before_filter :manager_authorized?, :find_property

  def new
    @floor_plan = FloorPlan.new
  end

  def show
    @floor_plan = FloorPlan.find(params[:id])
    @notification_contacts = @floor_plan.vacancy_notifications.map do |n|
      n.contact
    end
    @photos = @floor_plan.floor_plan_photos
  end

  def edit
    @floor_plan = @property.floor_plans.find(params[:id])
  end

  def create
    begin
      FloorPlan.transaction do
        @floor_plan = @property.floor_plans.create(params[:floor_plan])
      end
      flash[:notice] = 'Floor plan successfully created.'
      redirect_to m([@company, @property, @floor_plan])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, 'floor_plans/new'])
    end
  end

  def update
    begin
      floor_plan = @property.floor_plans.find(params[:id])
      floor_plan.update_attributes(params[:floor_plan])
      flash[:notice] = 'Floor plan successfully updated.'
      redirect_to m([@company, @property, floor_plan])
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to m([@company, @property, floor_plan, 'edit'])
    end
  end

  def destroy
    begin
      @floor_plan = FloorPlan.find(params[:id])
      @floor_plan.destroy
      flash[:notice] = 'Floor plan successfully deleted.'
    rescue Exception => e
      flash[:notice] = e.message
    end
    redirect_to m([@company, @property])
  end

end
