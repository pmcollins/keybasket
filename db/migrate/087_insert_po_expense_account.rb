class InsertPoExpenseAccount < ActiveRecord::Migration
  def self.up
    Account.create(
      :name => 'po_expenses',
      :account_type_id => AccountType.load('expense').id
    )
  end

  def self.down
    o = Account.load('purchase_order_expenses')
    o && o.destroy
  end
end
