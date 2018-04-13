class AddSomeRentalAgreementColumns < ActiveRecord::Migration
  def self.up
    add_column :rental_agreements, :notes, :text
    add_column :rental_agreements, :deposit, :integer
  end

  def self.down
    remove_column :rental_agreements, :notes
    remove_columns :rental_agreements, :deposit
  end
end
