class Lease < ActiveRecord::Base

  #validates_presence_of :rent, :rental_agreement_id

  belongs_to :rental_agreement

  has_one :rental_agreement
  has_one :move_out
  has_one :moveout_notice

  before_create :set_end_date

  def expired?
    Date.today > end_date
  end

  def set_end_date
    return unless (start_date && duration_months)
    self.end_date = (start_date + duration_months.months).beginning_of_month - 1
  end

  protected

  def validate
    errors.add(:rent, 'must be non-negative') if rent && rent < 0
  end

end
