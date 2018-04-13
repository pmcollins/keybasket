class InsertBasicAcctTypes < ActiveRecord::Migration

  def self.up
    down
    AccountType.create([
      {:name => 'bank', :inverted => false},
      {:name => 'cash', :inverted => false},
      {:name => 'asset', :inverted => false},
      {:name => 'credit_card', :inverted => false},
      {:name => 'liability', :inverted => true},
      {:name => 'income', :inverted => true},
      {:name => 'expense', :inverted => false},
      {:name => 'equity', :inverted => false},
      {:name => 'accounts_receivable', :inverted => false},
      {:name => 'accounts_payable', :inverted => false}
    ])
  end

  def self.down
    AccountType.delete_all
  end

end
