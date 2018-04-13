class PhotosController < ApplicationController

  def show
    photo = Photo.find(params[:id])
    send_data(
      Base64.decode64(photo.normalized),
      :filename => "keybasket_photo_#{photo.id}",
      :type => 'image/png',
      :disposition => 'inline'
    )
  end

  def thumb
    photo = Photo.find(params[:id])
    send_data(
      Base64.decode64(photo.thumb),
      :filename => "keybasket_thumb_#{photo.id}",
      :type => 'image/png',
      :disposition => 'inline'
    )
  end

end
