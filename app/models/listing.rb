class Listing < ActiveRecord::Base

  #validates_presence_of :unit_id, :listing_date, :rent

  belongs_to :unit

  has_many :showings

  def to_s
    'Current Listing'
  end

  protected

  def validate
    return unless rent
    errors.add(:rent, 'must be non-negative') if rent < 0
  end

end
