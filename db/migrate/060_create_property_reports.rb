class CreatePropertyReports < ActiveRecord::Migration
  def self.up
    create_table :property_reports do |t|
      t.column :name, :string
      t.column :property_id, :integer
      t.column :latest_rent_older_than_months, :integer
      t.column :is_vacant, :boolean
      t.column :notice_given, :boolean
      t.column :in_lease, :boolean
      t.column :rent_below_floorplan_average, :boolean
    end
  end

  def self.down
    drop_table :property_reports
  end
end
