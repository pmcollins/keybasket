class UnitPhotosController < ApplicationController

  before_filter :manager_authorized?, :find_unit

  def create
    UnitPhoto.transaction do
      photo = Photo.new(params[:photo])
      photo.save!
      unit_photo = UnitPhoto.new(params[:unit_photo])
      unit_photo.photo = photo
      unit_photo.unit_id = @unit_id
      unit_photo.save!
    end
    redirect_to m([@company, @property, @unit])
  end

  def show
    @unit_photo = UnitPhoto.find(params[:id])
    @photo = @unit_photo.photo
    @caption = @unit_photo.caption
  end

  def edit
    @unit_photo = UnitPhoto.find(params[:id])
    @photo = @unit_photo.photo
    @caption = @unit_photo.caption
  end

  def update
    UnitPhoto.transaction do
      unit_photo = UnitPhoto.find(params[:id])
      unit_photo.caption = params[:unit_photo][:caption]
      unit_photo.save
    end
    redirect_to m([@company, @property, @unit])
  end

  def destroy
    UnitPhoto.transaction do
      unit_photo = UnitPhoto.find(params[:id])
      photo = unit_photo.photo
      unit_photo.destroy
      photo.destroy
    end
    redirect_to m([@company, @property, @unit])
  end

end
