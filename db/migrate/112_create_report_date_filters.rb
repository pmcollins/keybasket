class CreateReportDateFilters < ActiveRecord::Migration
  def self.up
    create_table :report_date_filters do |t|
      t.string :search_type #absolute vs. relative
      t.date :date1, :date2
      t.integer :days_ago1, :days_ago2, :operator_id, :report_id, :relation_attribute_id
      t.timestamps
    end
  end

  def self.down
    drop_table :report_date_filters
  end
end
