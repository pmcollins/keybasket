class FlipPayabletypeInversion < ActiveRecord::Migration
  def self.up
    AccountType.load('accounts_payable').update_attributes(
      :inverted => true
    )
  end

  def self.down
    AccountType.load('accounts_payable').update_attributes(
      :inverted => false
    )
  end
end
