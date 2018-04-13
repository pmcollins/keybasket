class ManagerProperty < ActiveRecord::Base

  belongs_to :property
  belongs_to :manager

  def to_s
    "#{manager} #{property}"
  end

end
