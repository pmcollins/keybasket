class ModifyRentalagreements < ActiveRecord::Migration
  def self.up
    remove_column :rental_agreements, :current_rent
    add_column :rental_agreements, :next_months_rent, :integer
  end

  def self.down
    remove_column :rental_agreements, :next_months_rent
    add_column :rental_agreements, :current_rent, :integer
  end
end
