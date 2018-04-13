class ReceivableRent < ActiveRecord::Base

  validates_presence_of :company_id, :year, :month

  belongs_to :company

  has_many :account_updates, :as => :transfer

  def before_validation_on_create
    today = Date.today
    self.year   = today.year   unless self.year
    self.month  = today.month  unless self.month
  end

  def after_create
    source_account = Account.load('rent_income')
    target_account = Account.load('rents_receivable')
    rent_date = Date.new(self.year, self.month)
    self.company.create_rents_receivable(
      :transfer => self,
      :rent_date => rent_date,
      :source_account_id => source_account.id,
      :target_account_id => target_account.id
    )
  end

  def to_s
    self.month.to_s + '/' + self.year.to_s
  end

end

