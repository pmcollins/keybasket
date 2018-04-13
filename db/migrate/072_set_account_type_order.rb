class SetAccountTypeOrder < ActiveRecord::Migration
  def self.up
    i = 1
    %w(
      accounts_receivable
      bank
      income
      liability
      accounts_payable
      equity
      cash
      credit_card
      expense
      asset
    ).each do |name|
      at = AccountType.load(name)
      at.ordering = i
      at.save
      i += 1
    end
  end

  def self.down
  end
end
