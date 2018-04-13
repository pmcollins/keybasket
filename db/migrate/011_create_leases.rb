class CreateLeases < ActiveRecord::Migration
  def self.up
    create_table :leases do |t|
      t.column :rent, :integer
      t.column :deposit, :integer
      t.column :unit_id, :integer
      t.column :start_date, :date
      t.column :duration_months, :integer
      t.column :notes, :text
    end
  end

  def self.down
    drop_table :leases
  end
end
