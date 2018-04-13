class PropertyPhotosController < ApplicationController

  before_filter :manager_authorized?, :find_property

  def index
    @property_photos = @property.property_photos
  end

  def create
    photo = Photo.new(params[:photo])
    photo.save!
    property_photo = PropertyPhoto.new(params[:property_photo])
    property_photo.photo = photo
    property_photo.property_id = @property_id
    property_photo.save!
    redirect_to m([@company, @property])
  end

  def show
    @property_photo = PropertyPhoto.find(params[:id])
    @photo = @property_photo.photo
  end

  def edit
    @property_photo = PropertyPhoto.find(params[:id])
    @photo = @property_photo.photo
  end

  def update
    property_photo = PropertyPhoto.find(params[:id])
    property_photo.caption = params[:property_photo][:caption]
    property_photo.save
    redirect_to m([@company, @property])
  end

  def destroy
    PropertyPhoto.transaction do
      property_photo = PropertyPhoto.find(params[:id])
      photo = property_photo.photo
      property_photo.destroy
      photo.destroy
    end
    redirect_to p([@company, @property])
  end
end
