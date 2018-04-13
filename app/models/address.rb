class Address < ActiveRecord::Base

  #validates_presence_of :line1, :city, :state, :zip

  validates_format_of :state, :with => %r{^\w\w$}

  has_one :company
  has_many :contacts
  has_one :property

end
