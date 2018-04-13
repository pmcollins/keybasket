class CreateRentalAgreements < ActiveRecord::Migration
  def self.up
    create_table :rental_agreements do |t|
      t.column :unit_id, :integer
      t.column :current_rent, :integer
      t.column :move_in_date, :date
      t.column :move_out_date, :date
    end
  end

  def self.down
    drop_table :rental_agreements
  end
end
