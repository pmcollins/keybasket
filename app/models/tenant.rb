class Tenant < ActiveRecord::Base

  #validates_presence_of :rental_agreement_id, :contact_id

  belongs_to :rental_agreement
  belongs_to :contact

  has_many :outgoing_messages, :as => :sender
  has_many :incoming_messages, :as => :recipient

  has_many :notes, :as => :notable

  virtual_column(
    :name => 'first_name',
    :type => :string
  )

  virtual_column(
    :name => 'last_name',
    :type => :string
  )

  attr_accessor :fname, :lname

  before_validation_on_create :create_contact

  def initialize(p)
    if p
      self.lname = p[:lname]
      self.fname = p[:fname]
    end
    super(p)
  end

  def to_s
    contact.to_s
  end

  def first_name
    contact.first_name
  end

  def last_name
    contact.last_name
  end

  private

  def create_contact
    return unless (self.lname || self.fname)
    self.contact = Contact.create(
      :first_name => self.fname,
      :last_name => self.lname
    )
  end

end
