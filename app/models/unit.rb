class Unit < ActiveRecord::Base

  #validates_presence_of :apt, :property_id

  belongs_to :property
  belongs_to :floor_plan
  belongs_to :rental_agreement

  has_one :listing

  has_many :unit_photos

  has_many :move_outs
  has_many :phones, :as => :phoneable
  has_many :incoming_messages, :as => :recipient
  has_many :maintenance_requests

  has_many :account_updates

  def to_s
    "##{apt}"
  end

  def current_rent
    ra = self.rental_agreement
    return unless ra
    ra.current_rent
  end

  def latest_rent
    ra = self.rental_agreement
    return unless ra
    ra.latest_rent
  end

  def create_rents_receivable(p)
    p[:unit_id] = self.id
    if self.rental_agreement
      self.rental_agreement.create_rents_receivable(p)
    end
  end

  def get_open_maintenance_requests
    MaintenanceRequest.get_open_requests_by_unit_id(self.id)
  end

end
