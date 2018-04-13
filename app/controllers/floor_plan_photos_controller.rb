class FloorPlanPhotosController < ApplicationController

  before_filter :manager_authorized?, :find_floor_plan

  def create
    FloorPlanPhoto.transaction do
      photo = Photo.new(params[:photo])
      photo.save!
      floor_plan_photo = FloorPlanPhoto.new(params[:floor_plan_photo])
      floor_plan_photo.photo = photo
      floor_plan_photo.floor_plan_id = @floor_plan_id
      floor_plan_photo.save!
    end
    redirect_to m([@company, @property, @floor_plan])
  end

  def show
    @floor_plan_photo = FloorPlanPhoto.find(params[:id])
    @photo = @floor_plan_photo.photo
    @caption = @floor_plan_photo.caption
  end

  def edit
    @floor_plan_photo = FloorPlanPhoto.find(params[:id])
    @photo = @floor_plan_photo.photo
    @caption = @floor_plan_photo.caption
  end

  def update
    FloorPlanPhoto.transaction do
      floor_plan_photo = FloorPlanPhoto.find(params[:id])
      floor_plan_photo.caption = params[:floor_plan_photo][:caption]
      floor_plan_photo.save
    end
    redirect_to m([@company, @floor_plan])
  end

  def destroy
    FloorPlanPhoto.transaction do
      floor_plan_photo = FloorPlanPhoto.find(params[:id])
      photo = floor_plan_photo.photo
      floor_plan_photo.destroy
      photo.destroy
    end
    redirect_to m([@company, @floor_plan])
  end

end
