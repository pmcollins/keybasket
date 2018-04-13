class AddAccountTypeOrder < ActiveRecord::Migration
  def self.up
    add_column :account_types, :ordering, :integer
  end

  def self.down
    remove_column :account_types, :ordering
  end
end
