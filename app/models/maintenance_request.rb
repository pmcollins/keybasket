class MaintenanceRequest < ActiveRecord::Base

  belongs_to :property
  belongs_to :unit
  belongs_to :maintenance_request_status

  has_many :maintenance_request_updates

  def to_s
    "#{self.created_at} Maintenance Request"
  end

  def before_create
    self.maintenance_request_status_id = 1 unless self.maintenance_request_status_id
    self.property_id = self.unit.property_id unless self.property_id
  end

  def self.get_open_requests_by_property_id(property_id)
    self.find(
      :all,
      :conditions => [
        'maintenance_request_status_id = ? and property_id = ?',
        1, property_id
      ],
      :order => 'created_at'
    )
  end

  def self.get_open_requests_by_unit_id(unit_id)
    self.find(
      :all,
      :conditions => [
        'maintenance_request_status_id = ? and unit_id = ?',
        1, unit_id
      ],
      :order => 'created_at'
    )
  end

end
