class FloorPlan < ActiveRecord::Base

  #validates_presence_of :name, :property_id, :bedrooms, :bathrooms

  belongs_to :property
  has_many :units

  has_many :floor_plan_photos

  has_and_belongs_to_many :vacancy_notifications

  protected

  def validate
    if nominal_rent and nominal_rent < 0
      errors.add(:nominal_rent, 'must be positive')
    end
  end

end
