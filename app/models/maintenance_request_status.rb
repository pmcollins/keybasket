class MaintenanceRequestStatus < ActiveRecord::Base

  has_many :maintenance_request_updates
  has_many :maintenance_requests

  def self.get_default
    self.load('open')
  end

  def self.load(name)
    self.find_by_name(name)
  end

  def to_s
    self.name.humanize
  end

end
