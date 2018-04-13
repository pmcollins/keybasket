class RenameCurrentRentAmountColumn < ActiveRecord::Migration
  def self.up
    rename_column :current_rents, :rent, :amount
  end

  def self.down
    rename_column :current_rents, :amount, :rent
  end
end
