class PurchaseOrderLineItem < ActiveRecord::Base

  belongs_to :purchase_order
  belongs_to :measure_unit

  validates_presence_of :unit_price, :quantity, :description

  def before_create
    self.total_price = self.unit_price * self.quantity
  end

end
