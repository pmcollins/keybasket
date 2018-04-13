class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.column :unit_id, :integer
      t.column :rent, :integer
      t.column :lease_months, :integer
      t.column :listing_date, :date
      t.column :available_date, :date
    end
  end

  def self.down
    drop_table :listings
  end
end
