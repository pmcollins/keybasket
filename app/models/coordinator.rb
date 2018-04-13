class Coordinator < ActiveRecord::Base

  #validates_presence_of :company_id, :login_id, :contact_id

  belongs_to :company
  belongs_to :login
  belongs_to :contact

  has_many :outgoing_messages, :as => :sender
  has_many :incoming_messages, :as => :recipient

  has_many :purchase_orders, :as => :requisitioner

  has_many :reports, :as => :owner

  has_many :account_transfers

  def to_s
    "#{contact.first_name} #{contact.last_name}"
  end

end
