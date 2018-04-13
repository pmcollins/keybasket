class RentalAgreement < ActiveRecord::Base

  attr_accessor :rent

  belongs_to :unit
  belongs_to :lease
  has_one :moveout_notice
  has_one :move_out
  has_many :tenants
  has_many :leases
  has_many :current_rents, :order => 'effective_date asc'
  has_many :account_updates
  has_many :checks
  has_many :fees
  after_create :create_current_rent

  virtual_column(
    :name => 'is_active',
    :type => :boolean
  )

  virtual_column(
    :name => 'last_rent_increase_date',
    :type => :date
  )

  def initialize(p)
    self.rent = p[:rent] if p[:rent]
    super(p)
  end

  def is_active
    active?
  end

  def active?
    id == unit.rental_agreement_id
  end

  def to_s
    "#{active? ? 'Active' : 'Inactive'} Rental Agreement"
  end

  def current_rent(date = Date.today)
    current_rent = self.current_rents.find(
      :first,
      :conditions => ["effective_date <= ?", date.to_s(:db)],
      :order => "effective_date DESC"
    )
    current_rent ? current_rent : nil
  end

  def latest_rent
    self.current_rents.find(
      :first,
      :order => "effective_date DESC"
    )
  end

  def last_rent_increase_date
    latest_rent.effective_date
  end

  def latest_rent_effective_before?(some_date)
    rent = self.latest_rent
    return unless rent
    rent.effective_date < some_date
  end

  def is_latest_rent_effective_before(some_date)
    latest_rent_effective_before?(some_date)
  end

  def create_rents_receivable(p)
    p ||= {}
    p[:source_account_id] ||= Account.load('rent_income').id
    p[:target_account_id] ||= Account.load('rents_receivable').id
    current_rent = self.current_rent(p[:rent_date])
    AccountUpdate.transfer_funds(
      :company_id => p[:company_id] || self.unit.property.company.id,
      :property_id => p[:property_id],
      :unit_id => p[:unit_id],
      :rental_agreement_id => self.id,
      :source_account_id => p[:source_account_id],
      :target_account_id => p[:target_account_id],
      :transfer_amount => current_rent.amount,
      :transfer => p[:transfer]
    ) if current_rent #The tenant may have a rental agreement,
                      #but may not be paying rent yet.
  end

  def get_balance_by_account_name(name)
    self.account_updates.find(
      :all,
      :conditions => [
        'account_id = ?',
        Account.load(name).id
      ]
    ).sum do |account_update|
      account_update.net_update
    end
  end

  def get_balance_by_account_type(account_type)
    account_type.get_balance_by_rental_agreement_id(self.id)
  end

  def get_owed_accounts
    AccountType.load('accounts_receivable').accounts.reject do |account|
      account.get_balance_by_rental_agreement_id(self.id) <= 0
    end
  end

  def recalculate_rent_increases
    rent_history = self.current_rents 
    if rent_history.size > 1
      (1 .. rent_history.size-1).each do |i|
        cr = rent_history[i]
        cr.update_attributes(
          :increase_amount => cr.amount - rent_history[i-1].amount
        )
      end
    end
  end

  protected

  def validate
    errors.add(:deposit, 'must be non-negative') if deposit and deposit < 0
  end

  private
 
  def create_current_rent
    self.current_rents.create(
      :amount => self.rent,
      :effective_date => self.move_in_date
    ) if self.rent
  end

end
