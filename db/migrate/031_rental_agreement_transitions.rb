class RentalAgreementTransitions < ActiveRecord::Migration
  def self.up
    #1
    remove_column :tenants, :unit_id
    add_column :tenants, :rental_agreement_id, :integer

    #2
    remove_column :leases, :unit_id
    add_column :leases, :rental_agreement_id, :integer

    #3
    remove_column :move_outs, :lease_id
    add_column :move_outs, :rental_agreement_id, :integer
    remove_column :move_outs, :unit_id

    #4
    remove_column :moveout_notices, :lease_id
    add_column :moveout_notices, :rental_agreement_id, :integer

    #5
    remove_column :units, :lease_id
    add_column :units, :rental_agreement_id, :integer
  end

  def self.down
    #1
    remove_column :tenants, :rental_agreement_id
    add_column :tenants, :unit_id, :integer

    #2
    remove_column :leases, :rental_agreement_id
    add_column :leases, :unit_id, :integer

    #3
    remove_column :move_outs, :rental_agreement_id
    add_column :move_outs, :lease_id, :integer
    add_column :move_outs, :unit_id, :integer

    #4
    remove_column :moveout_notices, :rental_agreement_id
    add_column :moveout_notices, :lease_id, :integer

    #5
    remove_column :units, :rental_agreement_id
    add_column :units, :lease_id, :integer
  end
end
