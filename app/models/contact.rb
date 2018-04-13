class Contact < ActiveRecord::Base

  belongs_to :address

  has_one :tenant
  has_one :former_tenant
  has_one :manager

  has_many :phones, :as => :phoneable

  def to_s
    "#{first_name} #{last_name}"
  end

end
