class Manager < ActiveRecord::Base

  #validates_presence_of :company_id, :contact_id

  belongs_to :login
  belongs_to :contact
  belongs_to :company

  has_many :phones, :as => :phoneable
  has_many :outgoing_messages, :as => :sender
  has_many :incoming_messages, :as => :recipient
  has_many :purchase_orders, :as => :requisitioner
  has_many :reports, :as => :owner

  has_many :manager_properties
  has_many :properties, :through => :manager_properties

  def to_s
    "#{contact.first_name} #{contact.last_name}"
  end

end
