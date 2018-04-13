class AddLeaseToRentalAgreement < ActiveRecord::Migration
  def self.up
    add_column :rental_agreements, :lease_id, :integer
  end

  def self.down
    remove_column :rental_agreements, :lease_id
  end
end
