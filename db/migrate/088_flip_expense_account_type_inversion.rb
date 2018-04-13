class FlipExpenseAccountTypeInversion < ActiveRecord::Migration
  def self.up
    AccountType.load('expense').update_attributes(
      :inverted => true
    )
  end

  def self.down
    AccountType.load('expense').update_attributes(
      :inverted => false
    )
  end
end
