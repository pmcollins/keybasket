class Company < ActiveRecord::Base

  belongs_to :address

  has_many :properties
  has_many :managers
  has_many :coordinators
  has_many :purchase_orders
  has_many :vendors
  has_many :checks
  has_many :reports

  has_many :phones, :as => :phoneable
  has_many :incoming_messages, :as => :recipient

  has_many :receivable_rents
  has_many :account_updates

  def create_rents_receivable(p)
    p[:company_id] = self.id
    self.properties.each do |property|
      property.create_rents_receivable(p)
    end
  end

  def purchase_orders_pending
    self.purchase_orders.find(
      :all,
      :conditions => 'purchase_order_approval_id IS NULL'
    )
  end

end
