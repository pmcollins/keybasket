class VacancyNotification < ActiveRecord::Base

  belongs_to :property
  belongs_to :contact

  has_and_belongs_to_many :floor_plans

end
