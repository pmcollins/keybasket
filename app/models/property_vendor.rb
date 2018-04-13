class PropertyVendor < ActiveRecord::Base

  belongs_to :property
  belongs_to :vendor

  def to_s
    vendor
  end

end
