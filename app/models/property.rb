class Property < ActiveRecord::Base

  belongs_to :company
  belongs_to :address
  belongs_to :property_photo

  has_many :units
  has_many :floor_plans
  has_many :property_photos
  has_many :property_reports
  has_many :maintenance_requests
  has_many :phones, :as => :phoneable
  has_many :incoming_messages, :as => :recipient

  has_many :property_vendors
  has_many :vendors, :through => :property_vendors

  has_many :manager_properties
  has_many :managers, :through => :manager_properties

  has_many :notes, :as => :notable

  def self.find_with_listings
    find_by_sql(
      'SELECT DISTINCT p.* ' +
      'FROM listings l, units u, properties p ' +
      'WHERE l.unit_id = u.id ' +
      'AND u.property_id = p.id'
    )
  end

  def listings
    Listing.find_by_sql([
      'SELECT l.* ' +
      'FROM listings l, units u ' +
      'WHERE l.unit_id = u.id ' +
      'AND u.property_id = ?',
      id
    ])
  end

  def future_moveout_notices
    MoveoutNotice.find_by_sql([
      'SELECT mn.* ' +
      'FROM moveout_notices mn, rental_agreements ra, units u ' +
      'WHERE mn.rental_agreement_id = ra.id ' +
      'AND ra.unit_id = u.id ' +
      'AND mn.notice_date > CURRENT_DATE ' +
      'AND u.property_id = ? ',
      id
    ])
  end

  def current_and_upcoming_vacancy_units
    Unit.find_by_sql([
      'SELECT u.* ' +
      'FROM moveout_notices mn, rental_agreements ra, units u ' +
      'WHERE mn.rental_agreement_id = ra.id ' +
      'AND ra.unit_id = u.id ' +
      'AND mn.notice_date > CURRENT_DATE ' +
      'AND u.property_id = ? ' +
      'UNION ' +
      'SELECT u.* ' +
      'FROM units u ' +
      'WHERE u.rental_agreement_id IS NULL ' +
      'AND u.property_id = ? ',
      id, id
    ])
  end

  def rental_agreements
    self.units.map do |unit|
      unit.rental_agreement
    end
  end

  def rental_agreements_with_latest_rent_effective_before(some_date)
    out = []
    self.units.each do |unit|
      ra = unit.rental_agreement
      out.push(ra) if ra && ra.is_latest_rent_effective_before(some_date)
    end
    out
  end

  def rental_agreements_with_notice_given
  end

  def create_rents_receivable(p)
    p[:property_id] = self.id
    self.units.each do |unit|
      unit.create_rents_receivable(p)
    end
  end

  def get_open_maintenance_requests
    MaintenanceRequest.get_open_requests_by_property_id(self.id)
  end

end
