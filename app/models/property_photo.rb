class PropertyPhoto < ActiveRecord::Base

  belongs_to :property
  belongs_to :photo

end
