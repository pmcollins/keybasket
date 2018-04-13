class Operator < ActiveRecord::Base

  has_many :report_date_filters

  def is_between?
    id >= 7
  end

end
