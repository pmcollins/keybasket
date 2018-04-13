class CreateRentIncreases < ActiveRecord::Migration
  def self.up
    create_table :rent_increases do |t|
      t.column :rental_agreement_id, :integer
      t.column :previous_rent, :integer
      t.column :increase_amount, :integer
      t.column :effective_date, :date
    end
  end

  def self.down
    drop_table :rent_increases
  end
end
