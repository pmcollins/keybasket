class FloorPlanPhoto < ActiveRecord::Base

  belongs_to :floor_plan
  belongs_to :photo

end
