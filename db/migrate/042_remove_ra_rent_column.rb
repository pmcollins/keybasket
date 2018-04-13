class RemoveRaRentColumn < ActiveRecord::Migration
  def self.up
    remove_column :rental_agreements, :next_months_rent
  end

  def self.down
    add_column :rental_agreements, :next_months_rent, :integer
  end
end
