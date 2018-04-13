class MeasureUnit < ActiveRecord::Base

  has_many :purchase_order_line_items

end
