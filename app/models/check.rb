class Check < ActiveRecord::Base

  belongs_to :rental_agreement
  belongs_to :account
  belongs_to :company

  has_many :check_transactions

  #XXX TODO FIXME unique check numbers please!
  #solves check transaction race condition issue

  def self.related_account_names
    %w(
      rents_receivable
      undeposited_funds
      deposited_funds
    )
  end

  def get_last_check_transaction
    self.check_transactions.find(
      :first,
      :order => 'id DESC'
    )
  end

  def get_target_account_candidate_names
    self.class.related_account_names - [self.account.name]
  end

  def to_s
    'Check'
  end

end

