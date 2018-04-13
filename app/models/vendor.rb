class Vendor < ActiveRecord::Base

  belongs_to :company
  has_many :purchase_orders
  has_many :account_updates

  has_many :property_vendors
  has_many :properties, :through => :property_vendors

end
