require 'RMagick'
class Photo < ActiveRecord::Base
  include Magick

  has_one :property_photo

  def uploaded_file=(f)
    img = Magick::Image::read_inline(Base64.encode64(f.read)).first
    [['normalized', 400], ['thumb', 100]].each do |o|
      resized = img.resize_to_fit(o[1], o[1])
      resized.format = 'PNG'
      self.update_attribute(o[0], Base64.encode64(resized.to_blob))
    end
  end

end
