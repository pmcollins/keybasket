class AddCurrentRent < ActiveRecord::Migration
  def self.up
    add_column :rental_agreements, :current_rent_id, :integer
    remove_column :rental_agreements, :next_months_rent
  end

  def self.down
    remove_column :rental_agreements, :current_rent_id
    add_column :rental_agreements, :next_months_rent, :integer
  end
end
