class InsertOrdersPayable < ActiveRecord::Migration
  def self.up
    Account.create(
      :name => 'orders_payable',
      :account_type_id => AccountType.load('accounts_payable').id
    )
  end

  def self.down
    o = Account.load('orders_payable')
    o && o.destroy
  end
end
