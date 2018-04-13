class AccountTypesFlow < ActiveRecord::Migration
  def self.up
    #delete -- not used:
    %w(
      cash
      asset
      credit_card
      equity
    ).each do |account|
      AccountType.load(account).destroy
    end
    i = 1
    %w(
      income
      accounts_receivable
      bank
      liability
      accounts_payable
      expense
    ).each do |name|
      AccountType.load(name).update_attributes(:ordering => i)
      i += 1
    end
    FlipExpenseAccountTypeInversion.down
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration #lazy
  end
end
