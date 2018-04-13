class DecimalizeCurrencyColumns < ActiveRecord::Migration
  def self.up
    remove_column :current_rents, :rent
    add_column    :current_rents, :rent, :decimal, :precision => 8, :scale => 2

    remove_column :floor_plans, :nominal_rent
    add_column    :floor_plans, :nominal_rent, :decimal, :precision => 8, :scale => 2

    remove_column :leases, :rent
    add_column    :leases, :rent, :decimal, :precision => 8, :scale => 2

    remove_column :listings, :rent
    add_column    :listings, :rent, :decimal, :precision => 8, :scale => 2

    remove_column :rental_agreements, :deposit
    add_column    :rental_agreements, :deposit, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :current_rents, :rent
    add_column    :current_rents, :rent, :integer

    remove_column :floor_plans, :nominal_rent
    add_column    :floor_plans, :nominal_rent, :integer

    remove_column :leases, :rent
    add_column    :leases, :rent, :integer

    remove_column :listings, :rent
    add_column    :listings, :rent, :integer

    remove_column :rental_agreements, :deposit
    add_column    :rental_agreements, :deposit, :integer
  end
end
