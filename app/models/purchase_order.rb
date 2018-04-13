class PurchaseOrder < ActiveRecord::Base

  belongs_to :company
  belongs_to :vendor
  belongs_to :ship_to_address, :class_name => 'Address', :foreign_key => 'ship_to_address_id'

  belongs_to :requisitioner, :polymorphic => true

  has_many :purchase_order_line_items

  belongs_to :purchase_order_approval

  def to_s
    self.title
  end

  def get_status
    is_approved? ? 'approved' : 'pending'
  end

  def is_approved?
    !purchase_order_approval_id.nil?
  end

end
